//
//  PlaylistListVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class PlaylistListVCCC: UITableViewController {
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Your Playlists"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Your Playlists"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        needs to return self.playlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistListCell", for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistDetailTableViewCell
//        cell.songNameLabel.text = "\(indexPath.row). " + self.songs.top10SongArray[indexPath.row].name
//        cell.artistNameLabel.text = self.songs.top10SongArray[indexPath.row].artist
        cell.textLabel?.text = subtitleLabel.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
