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
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Your Playlists"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.separatorStyle = .none
        
        navigationItem.title = "Your Playlists"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(PlaylistListTableViewCell.self, forCellReuseIdentifier: "PlaylistListCell")
        
        if playlist == nil {
            playlist = Playlist()
        }
        fetchCurrentUser()
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
//            self.getPlaylists()
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
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistListCell", for: indexPath) as! PlaylistListTableViewCell
        //        cell.textLabel?.text = subtitleLabel.text
        
        if indexPath.row == 0 {
            cell.playlistNameLabel.text = "Top Ten"
        } else if indexPath.row == 1 {
            cell.playlistNameLabel.text = "Hot Ten"
        } else {
            cell.playlistNameLabel.text = "Some Random Playlist"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.addSubview(addIcon)
        // might need to make footer uneditable
        addIcon.anchor(top: nil, left: nil, bottom: footerView.bottomAnchor, right: footerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -30, paddingRight: 30, width: 45, height: 45)
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
}
