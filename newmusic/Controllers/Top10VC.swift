//
//  Top10VC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/2/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class Top10VC: UITableViewController {

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

        self.tableView.register(PlaylistDetailTableViewCell.self, forCellReuseIdentifier: "Top10Cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Top10Cell", for: indexPath) as! PlaylistDetailTableViewCell
//        cell.textLabel!.text = subtitleLabel.text!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


}
