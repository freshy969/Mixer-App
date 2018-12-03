//
//  SearchMenuVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class SearchMenuVC: UIViewController {
    
    let searchMenuController = MenuVC()
    
    let searchContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchMenuView = searchMenuController.view!
        
        view.addSubview(searchMenuView)
        view.addSubview(searchContainer)
        
        searchContainer.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 105)
        
        searchMenuView.anchor(top: searchContainer.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
//        searchMenuView.fillSuperview()
    }

}
