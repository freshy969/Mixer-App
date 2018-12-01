//
//  DetailMenuVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class DetailMenuVC: UIViewController {

    let menuController = MenuVC()
    let footerView = FooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let menuView = menuController.view!
//        view.addSubview(menuView)
//        view.addSubview(footerView)
//
//        menuView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 530)
//        
//        footerView.anchor(top: menuView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

class FooterView: UIView {
    
    let searchIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "searchBlack")
//        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .yellow
        addSubview(searchIcon)
        
        searchIcon.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 140, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

