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

class HomeVC: UITableViewController, UIGestureRecognizerDelegate {
    
    var profilePic = "joe"
    var username = "joelangenderfer" // Must capitalize
    var playlistNameArray = ["Coding Jams", "Pregame Songs", "Cheery EDM", "Chillout Vibes", "My Top 10", "Chillout Vibes"]
    var songArray = ["Divide", "No Problem", "Winnebago", "Some Odesza Song", "Closer", "Some Odesza Song"]
    var artistArray = ["Odesza", "Chance the Rapper", "Gryffin", "Odesza", "The Chainsmokers", "Odesza"]
    var albumCoverArray = ["odesza", "chance", "winn", "odesza2", "chainsmokers", "odesza3"]
    
    let menuController = MenuVC()
    fileprivate let menuWidth: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        self.tableView.register(TimelineTableViewCell.self, forCellReuseIdentifier: "cellId")
        fetchCurrentUser()
        setupNavigationBarItems()
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .heavy)]
    }
    
    var user: MusicUser!
    
    fileprivate func setupCircularNavigationButton() {
        
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        
        let imageName = self.user?.profileURL ?? ""
        let url = URL(string: imageName)
        customView.sd_setBackgroundImage(with: url, for: .normal)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCurrentUser()
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
            
            self.tableView.reloadData() // need to reload table one more time
            self.setupCircularNavigationButton()
        }
    }

    @objc func openMessages() {
        
    }
    
    func hideCircularNavigationButton() {
        navigationItem.leftBarButtonItem = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TimelineTableViewCell
        cell.selectionStyle = .none

        cell.card.profilePictureButton.setImage(UIImage(named: profilePic)?.withRenderingMode(.alwaysOriginal), for: .normal)
        // if profile picture is nil then show the placeholder image
        // will need to create another view with an image inside of it so that the background can be the averageColor
        cell.card.usernameButtonLabel.text = "@" + username.uppercased()
        cell.card.playlistNameButtonLabel.text = playlistNameArray[indexPath.row].capitalized
        cell.card.songNameButtonLabel.text = songArray[indexPath.row]
        cell.card.artistNameButtonLabel.text = artistArray[indexPath.row]
        cell.card.albumImage.image = UIImage(named: albumCoverArray[indexPath.row])
        cell.card.likeTotalButtonLabel.text = "198 likes"
        cell.card.applyAverageColor()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 475
    }
}
