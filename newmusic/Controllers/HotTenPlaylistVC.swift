//
//  HotTenPlaylistVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/1/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HotTenPlaylistVC: UITableViewController {

    let customHeaderView = CustomPlaylistHeaderView()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "Your Favorite Songs Right Now".uppercased()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Hot 10"
        
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        self.tableView.register(PlaylistDetailTableViewCell.self, forCellReuseIdentifier: "PlaylistCell")
        loadUserPhotos()
        songs = Songs()
        fetchCurrentUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    var user: MusicUser!
    var songs: Songs!
    
    fileprivate func getPlaylistSongs() {
        
        self.songs.loadHot10SongData(user: self.user) {
            self.tableView.reloadData()
        }
    }

    
    fileprivate func fetchCurrentUser() {
        // fetch some Firestore Data
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
        customHeaderView.playlistName.text = "My Hot 10"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return customHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.hot10SongArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistDetailTableViewCell
        cell.songNameLabel.text = "\(indexPath.row + 1). " + self.songs.hot10SongArray[indexPath.row].name
        cell.artistNameLabel.text = self.songs.hot10SongArray[indexPath.row].artist
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


}
