//
//  MenuVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/27/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

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
    
    let customHeaderView = CustomMenuHeaderView()
    
    let menuItems = [
        MenuItem(icon: UIImage(named: "homeGray")!, title: "Home"),
        MenuItem(icon: UIImage(named: "favelist")!, title: "Your Top 10"),
        MenuItem(icon: UIImage(named: "fireGray")!, title: "Your Hot 10"),
        MenuItem(icon: UIImage(named: "playlist")!, title: "Playlists"),
        MenuItem(icon: UIImage(named: "queueGray")!, title: "Queue"),
//        MenuItem(icon: UIImage(named: "searchGray")!, title: "Search"),
//        MenuItem(icon: UIImage(named: "addGray")!, title: "Add a Song")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.tableView.register(MenuItemCell.self, forCellReuseIdentifier: "menuCellId")
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
