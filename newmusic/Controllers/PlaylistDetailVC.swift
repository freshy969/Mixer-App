//
//  PlaylistDetailVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/3/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

protocol receivePlaylist {
    func pass(data: Playlist)
}

class PlaylistDetailVC: UITableViewController, receivePlaylist {

    let customHeaderView = CustomPlaylistHeaderView()
    var selectedPlaylist: Playlist!
    
    let rightBarButton = UIButton()
    
    func pass(data: Playlist) {
        // set up the button text
        selectedPlaylist = data
        // will need to fetch user in viewdidload too
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        setupNavBarItems()
        self.tableView.register(PlaylistDetailTableViewCell.self, forCellReuseIdentifier: "PlaylistCell")
        loadUserPhotos()
        songs = Songs()
        fetchCurrentUser()
    }
    
    fileprivate func setupNavBarItems() {
        navigationItem.title = selectedPlaylist.name
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    var user: MusicUser!
    var songs: Songs!
    
    fileprivate func getPlaylistSongs() {
        
        self.songs.loadCustomPlaylistSongs(user: self.user, playlist: selectedPlaylist) {
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
            self.configureHeader()
            self.getPlaylistSongs()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func loadUserPhotos() {
        // to cache the photos
        guard let imageUrl = user?.profileURL, let url = URL(string: imageUrl) else { return }
        SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
            self.customHeaderView.profileImageView.image = image?.withRenderingMode(.alwaysOriginal) ?? UIImage(named: "")
        }
    }
    
    fileprivate func configureHeader() {
        let imageName = self.user?.profileURL ?? ""
        if let url = URL(string: imageName) {
            customHeaderView.profileImageView.sd_setImage(with: url)
        } else {
            // return the default image
        }
        customHeaderView.playlistDesc.text = "A PLAYLIST BY \(user?.fullName.uppercased() ?? "USER")"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return customHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.customPlaylistSongArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistDetailTableViewCell
        cell.songNameLabel.text = self.songs.customPlaylistSongArray[indexPath.row].name
        cell.artistNameLabel.text = self.songs.customPlaylistSongArray[indexPath.row].artist
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
