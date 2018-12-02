//
//  TopTenPlaylistVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class TopTenPlaylistVC: UIViewController {

    // will want to build a basic playlist controller, then add in separate components
    
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
    
        navigationItem.title = "Your Top 10"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        view.backgroundColor = .white
        view.addSubview(subtitleLabel)
        subtitleLabel.frame = view.frame
        subtitleLabel.textAlignment = .center
        
    }

}
