//
//  ViewController.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/16/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var username = "Joelangenderfer" // make sure to all caps this
    var profilePic: UIImage? = nil //UIImage(named: "joe")
    var songArray = ["Divide", "A Moment Apart", "Across The Room (feat. Leon Bridges)", "Falls (feat. Sasha Sloan)", "Line of Sight (feat. WYNNE & Mansionair", "Higher Ground (feat. Naomi Wild"]
    var artistArray = ["Odesza", "Odesza", "Odesza", "Odesza", "Odesza", "Odesza"]
    var playlistArray = ["Coding Tunes", "Coding Tunes", "Coding Tunes", "Coding Tunes", "Coding Tunes", "Coding Tunes"] // Make sure to capitalize the first letter of each of these
    var albumCoverArray = ["odesza", "chance", "winn", "odesza2", "odesza3", "joe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        setupNavigationBarItems()
    }
    
    @objc func handleOpen() {
        let vc = MenuVC()
        vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: self.view.frame.height)
        
        let mainWindow = UIApplication.shared.keyWindow
        // UIApplication represents an application class - one instance of an object (a singleton). The singleton allows us to access the keyWindow which is everything inside of our app
        mainWindow?.addSubview(vc.view)
        // view.addSubview(vc.view)
    }
    
    @objc func handleHide() {
    }
    
    fileprivate func setupNavigationBarItems() {
        
        //        navigationItem.titleView = UIImageView(image: UIImage(named: "Newmusic-Astro")?.withRenderingMode(.alwaysOriginal))
        //        navigationItem.titleView?.contentMode = .scaleAspectFit
        
        navigationItem.title = "Your Newmusic"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as! TimelineTableViewCell
        cell.setupCardUI()
        
        cell.usernameButtonLabel.setTitle(username, for: .normal)
    cell.playlistNameButtonLabel.setTitle(playlistArray[indexPath.row], for: .normal)
        cell.songNameButtonLabel.setTitle(songArray[indexPath.row], for: .normal)
        cell.artistNameButtonLabel.setTitle(artistArray[indexPath.row], for: .normal)
        
        if profilePic != nil {
            //cell.profilePictureView.backgroundColor = UIColor.white
            cell.profilePictureImageView.image = profilePic
            cell.userButton.backgroundColor = UIColor.clear
        }
        cell.albumImage.image = UIImage(named: albumCoverArray[indexPath.row])
        cell.applyAverageColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}


