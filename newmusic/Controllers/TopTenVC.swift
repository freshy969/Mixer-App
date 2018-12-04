//
//  TopTenVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/3/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ContainerView: UIView {}

class TopTenPlaylistVC: UITableViewController {
    
    let customHeaderView = CustomPlaylistHeaderView()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "Your Favorite Songs of All Time".uppercased()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top 10"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.register(PlaylistDetailTableViewCell.self, forCellReuseIdentifier: "PlaylistCell")
        loadUserPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCurrentUser()
//        configureHeader()
    }
    
    var user: MusicUser!
    
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
            self.tableView.reloadData() // need to reload table one more time
            self.configureHeader()
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
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistDetailTableViewCell
        cell.textLabel?.text = "Favorite Song Ever #\(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
