//
//  MenuVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/27/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import JGProgressHUD

struct MenuItem {
    let icon: UIImage
    let title: String
}

extension MenuVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // how do we access BaseSlidingController.closeMenu()
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC
        slidingController?.didSelectMenuItem(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class MenuVC: UITableViewController {
    
    var customHeaderView = CustomMenuHeaderView()
    
    let menuItems = [
        MenuItem(icon: UIImage(named: "homeGray")!, title: "Home"),
        MenuItem(icon: UIImage(named: "favelist")!, title: "Your Top 10"),
        MenuItem(icon: UIImage(named: "fireGray")!, title: "Your Hot 10"),
        MenuItem(icon: UIImage(named: "playlist")!, title: "Playlists"),
        MenuItem(icon: UIImage(named: "queueGray")!, title: "Queue")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.tableView.register(MenuItemCell.self, forCellReuseIdentifier: "menuCellId")
        loadUserPhotos()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCurrentUser()
        configureHeader()
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
        let header = customHeaderView
        let imageName = self.user?.profileURL ?? ""
        if let url = URL(string: imageName) {
            header.profileImageView.sd_setImage(with: url)
        } else {
            
            // return the default image
        }
        
        let fullName = self.user?.fullName ?? ""
        let userName = self.user?.displayName ?? ""
        
        header.nameLabel.text = fullName
        header.usernameLabel.text = "@" + userName
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        configureHeader()
        return customHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCellId", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.row]
        cell.iconImageView.image = menuItem.icon
        cell.titleLabel.text = menuItem.title
        // pass over the user when one is clicked
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
