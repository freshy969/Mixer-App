//
//  QueueListVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class QueueListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Your Queue"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Your Queue"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)
    }
}
