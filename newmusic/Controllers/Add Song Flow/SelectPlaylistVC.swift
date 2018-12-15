//
//  SelectPlaylistVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/13/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase

class SelectPlaylistVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: MusicUser!
    var playlist: Playlist!
    var playlists: Playlists!
    var tableView = UITableView()
    
    var delegate: isAbleToReceiveData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PlaylistListTableViewCell.self, forCellReuseIdentifier: "PlaylistListCell")
        
        if playlist == nil {
            playlist = Playlist()
        }
        playlists = Playlists()
        fetchCurrentUser()
    }
    
    fileprivate func setupNavigationBar() {
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Playlists"
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    fileprivate func getPlaylists() {
        self.playlists.loadPlaylists(user: self.user) {
            self.tableView.reloadData()
        }
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

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.playlistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistListCell", for: indexPath) as! PlaylistListTableViewCell
        //        cell.textLabel?.text = subtitleLabel.text
        cell.playlistNameLabel.text = self.playlists.playlistArray[indexPath.row].name
        cell.playlistSubtitleLabel.text = "\(self.playlists.playlistArray[indexPath.row].numberOfSongs) Songs"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playlist = playlists.playlistArray[indexPath.row]
        delegate.pass(data: playlist)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


