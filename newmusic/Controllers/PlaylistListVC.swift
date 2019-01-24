//
//  PlaylistListVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/12/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase

class PlaylistListVC: UITableViewController {
    
    var user: MusicUser!
    var playlist: Playlist!
    var selectedPlaylist: Playlist!
    var playlists: Playlists!
    
    var delegate: receivePlaylist!
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Playlists"
        label.textAlignment = .center
        return label
    }()
    
    let addIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "addColor"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(addPlaylist), for: .touchUpInside)
        return iv
    }()
    
    let rightBarButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none

        setupNavBarItems()
        self.tableView.register(PlaylistListTableViewCell.self, forCellReuseIdentifier: "PlaylistListCell")
        
        if playlist == nil {
            playlist = Playlist()
        }
        playlists = Playlists()
        fetchCurrentUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // will need to call loadCustomPlaylistSongs in order to get the number of songs displayed before view appears
    }
    
    fileprivate func setupNavBarItems() {
        navigationItem.title = "Your Playlists"
        
        rightBarButton.setTitle("Edit", for: .normal)
        rightBarButton.setTitleColor(.blue, for: .normal)
        rightBarButton.addTarget(self, action: #selector(editBarButtonPressed), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(rightBarButton)
        rightBarButton.tag = 1
        rightBarButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 120, height: 20)
        
        let targetView = self.navigationController?.navigationBar
        
        let trailingContraint = NSLayoutConstraint(item: rightBarButton, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -16)
        let bottomConstraint = NSLayoutConstraint(item: rightBarButton, attribute: .bottom, relatedBy: .equal,
                                                  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -10)
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    fileprivate func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            
            // fetched our user here
            guard let dictionary = snapshot?.data() else { return }
            self.user = MusicUser(dictionary: dictionary)
            self.getPlaylists()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func getPlaylists() {
        self.playlists.loadPlaylists(user: self.user) {
            self.tableView.reloadData()
        }
    }
    
    @objc fileprivate func addPlaylist() {
        let alert = UIAlertController(title: "Add a New Playlist", message: "Enter a name for your new playlist", preferredStyle: .alert)
        
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            self.playlist.name = textField.text!
            self.playlist.savePlaylist(user: self.user, completed: { (success) in
            })
        })
        createAction.isEnabled = false

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(createAction)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Playlist name"
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[0], queue: OperationQueue.main) { (notification) -> Void in
                
                let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                let textIsNotEmpty = textCount > 0
                
                createAction.isEnabled = textIsNotEmpty
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        if section == 0 {
            label.text = "  Your Droplists"
            return label
        }
        label.text = "  Your Customized Playlists"
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return playlists.playlistArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // push top10
            } else {
                // push hot10
            }
        }
        
        if indexPath.section == 1 {
            selectedPlaylist = playlists.playlistArray[indexPath.row]
            print(selectedPlaylist.name)
            
            let selectedPlaylistController = PlaylistDetailVC()
            delegate = selectedPlaylistController
            delegate.pass(data: selectedPlaylist)
            self.navigationController?.pushViewController(selectedPlaylistController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistListCell", for: indexPath) as! PlaylistListTableViewCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.playlistNameLabel.text = "Your Top 10"
                cell.playlistSubtitleLabel.text = "Your ten favorite songs of all time"
            } else if indexPath.row == 1 {
                cell.playlistNameLabel.text = "Your Hot 10"
                cell.playlistSubtitleLabel.text = "Your ten favorite songs right now"
            }
        } else {
            cell.playlistNameLabel.text = self.playlists.playlistArray[indexPath.row].name
            cell.playlistSubtitleLabel.text = "\(self.playlists.playlistArray[indexPath.row].numberOfSongs) Songs"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.addSubview(addIcon)
        // might need to make footer uneditable
        addIcon.anchor(top: nil, left: nil, bottom: footerView.bottomAnchor, right: footerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 25, width: 45, height: 45)
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    @objc fileprivate func editBarButtonPressed() {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addIcon.isEnabled = true
            rightBarButton.setTitle("Edit", for: .normal)
        }
        else {
            tableView.setEditing(true, animated: true)
            addIcon.isEnabled = false
            rightBarButton.setTitle("Done", for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if editingStyle == .delete {
                playlists.playlistArray[indexPath.row].deletePlaylist(user: self.user) { (success) in
                }
                //                self.playlists.playlistArray.remove(at: indexPath.row)
                //                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        return false
    }
    
    //    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //        let itemToMove = playlists.playlistArray[sourceIndexPath.row]
    //        playlists.playlistArray.remove(at: sourceIndexPath.row)
    //        playlists.playlistArray.insert(itemToMove, at: destinationIndexPath.row)
    ////        saveDefaultsData()
    //    }
}
