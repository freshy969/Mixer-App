//
//  HomeVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/29/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import JGProgressHUD

class HomeVC: UITableViewController, UIGestureRecognizerDelegate {
    
    var user: MusicUser!
    var songs: Songs!
    
    var profilePic = ""
    var username = "" // Must capitalize
    var playlistNameArray = ["Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs", "Top Songs"]
    var totalSongAray: [Song] = []
//    var songArray = ["Divide", "No Problem", "Winnebago", "Some Odesza Song", "Closer", "Some Odesza Song"]
//    var artistArray = ["Odesza", "Chance the Rapper", "Gryffin", "Odesza", "The Chainsmokers", "Odesza"]
    var albumCoverArray = ["drake", "chance", "winn", "moon", "led", "wave", "pink", "drake", "chance", "winn", "moon", "led", "wave", "pink"]
    
    let menuController = MenuVC()
    fileprivate let menuWidth: CGFloat = 300
    
    let loadingHUD = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        self.tableView.register(TimelineTableViewCell.self, forCellReuseIdentifier: "cellId")
        self.tableView.register(NewsfeedHeaderCell.self, forCellReuseIdentifier: "headerCellId")
        songs = Songs()
        fetchCurrentUser()
        navigationController?.isNavigationBarHidden = true
//        setupNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingHUD.show(in: view)
        fetchCurrentUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingHUD.dismiss(animated: true)
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
    }
    
    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.closeMenu()
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupNavigationBarItems() {
        navigationItem.title = "Your New Music"
        setupCircularNavigationButton()
        setupRightNavigationButton()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
    }
    
    fileprivate func setupCircularNavigationButton() {
        
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        
        let imageName = self.user?.profileURL ?? "" //
        let url = URL(string: imageName) //
        customView.sd_setBackgroundImage(with: url, for: .normal) //
        
        customView.imageView?.contentMode = .scaleAspectFit
        
        customView.layer.cornerRadius = 30 / 2
        customView.clipsToBounds = true

        customView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    fileprivate func setupRightNavigationButton() {
        let image = UIImage(named: "sendBlack")!.withRenderingMode(.alwaysOriginal)
        let customView = UIButton(type: .system)
        
        customView.addTarget(self, action: #selector(openMessages), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        
        customView.clipsToBounds = true

        customView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
    
    fileprivate func getPlaylistSongs() {
        
        self.songs.loadTop10SongData(user: self.user) {
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
            
            self.getPlaylistSongs()
            self.tableView.reloadData() // need to reload table one more time
//            self.setupCircularNavigationButton()
        }
    }

    @objc func openMessages() {
        
    }
    
    func hideCircularNavigationButton() {
        navigationItem.leftBarButtonItem = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (songs.top10SongArray.count) + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCellId", for: indexPath) as! NewsfeedHeaderCell
            cell.selectionStyle = .none
            cell.customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
            
            let imageName = self.user?.profileURL ?? "" //
            let url = URL(string: imageName) //
            cell.customView.sd_setBackgroundImage(with: url, for: .normal) //
            
            cell.customView.imageView?.contentMode = .scaleAspectFill
            cell.customView.layer.cornerRadius = 35 / 2
            cell.customView.clipsToBounds = true
            
            cell.welcomeTitle.text = "Welcome, \(self.user?.firstName ?? "")"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TimelineTableViewCell
            cell.selectionStyle = .none
            
            let imageName = self.user?.profileURL ?? ""
            if let url = URL(string: imageName) {
                cell.card.profilePictureButton.sd_setImage(with: url, for: .normal)
            } else {
                // return the default image
            }
            // if profile picture is nil then show the placeholder image
            // will need to create another view with an image inside of it so that the background can be the averageColor
            cell.card.usernameButtonLabel.text = "@" + user.displayName
            cell.card.playlistNameButtonLabel.text = playlistNameArray[indexPath.row - 1].capitalized
            
            cell.card.songNameButtonLabel.text = songs.top10SongArray[indexPath.row - 1].name
            cell.card.artistNameButtonLabel.text = songs.top10SongArray[indexPath.row - 1].artist
            
            cell.card.albumImage.image = UIImage(named: albumCoverArray[indexPath.row - 1])
            
            // Grabbing the last of the array is irrelevant right now
            // Need to grab time posted from db and first sort the array (in viewdidappear)
            // Then once sorted we must take the most recent (will probably now be at the front of the sorted array)
            
            cell.card.likeTotalButtonLabel.text = "198 likes"
            cell.card.applyAverageColor()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        } else {
            return 470
        }
    }
}
