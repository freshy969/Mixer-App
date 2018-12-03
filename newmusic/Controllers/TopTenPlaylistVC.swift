////
////  TopTenPlaylistVC.swift
////  newmusic
////
////  Created by Joe Langenderfer on 11/30/18.
////  Copyright © 2018 Joe Langenderfer. All rights reserved.
////
//
//import UIKit
//
//class TopTenPlaylistVC: UITableView {
//
//    // will want to build a basic playlist controller, then add in separate components
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        navigationItem.title = "Your Top 10"
//
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//        }
//
//        view.backgroundColor = .white
//        view.addSubview(subtitleLabel)
//        subtitleLabel.frame = view.frame
//        subtitleLabel.textAlignment = .center
//
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return customHeaderView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 200
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menuItems.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCellId", for: indexPath) as! MenuItemCell
//        let menuItem = menuItems[indexPath.row]
//        cell.iconImageView.image = menuItem.icon
//        cell.titleLabel.text = menuItem.title
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//
//}
