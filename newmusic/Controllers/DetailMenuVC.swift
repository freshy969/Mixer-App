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
        
        let menuView = menuController.view!
        view.addSubview(menuView)
        view.addSubview(footerView)

        menuView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 750)
        
        footerView.anchor(top: menuView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
    }
    
}

class FooterView: UIView {
    
    let searchIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "searchGray")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let addIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "addGray")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        addSubview(searchIcon)
        addSubview(addIcon)
        
        searchIcon.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: -30, paddingRight: 0, width: 30, height: 30)
        addIcon.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -30, paddingRight: 20, width: 30, height: 30)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

