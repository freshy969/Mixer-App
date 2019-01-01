//
//  NewsfeedDetailViewController.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/20/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class NewsfeedDetailViewController: UITableViewController {

    let customHeaderView = CustomPlaylistHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PlaylistDetailTableViewCell.self, forCellReuseIdentifier: "PlaylistCell")
        // Do any additional setup after loading the view.
    }
    
    internal func positionContainer(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        self.view.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: top, paddingLeft: left, paddingBottom: bottom, paddingRight: right, width: 0, height: 0)
        view.layoutIfNeeded()
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
