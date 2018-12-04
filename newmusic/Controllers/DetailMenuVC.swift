//
//  DetailMenuVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase

class DetailMenuVC: UIViewController {
    
    var user: MusicUser!
    
    let menuController = MenuVC()
    let footerView = FooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = menuController.user
        
        let menuView = menuController.view!
        view.addSubview(menuView)
        view.addSubview(footerView)
        
        menuController.customHeaderView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        self.footerView.addIcon.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)

        menuView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 550)
        
        footerView.anchor(top: menuView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        super.viewDidAppear(animated)
        if currentUser == nil {
            let loginController = LoginVC()
            let navContoller = UINavigationController(rootViewController: loginController)
            self.present(navContoller, animated: true)
        } else {
            user = MusicUser(user: currentUser!)
        }
    }
    
    @objc func handleSettings() {
        showSettingsActionSheet()
    }
    
    func showSettingsActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            print("Settings")
        }
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            try? Auth.auth().signOut()
            print("Logged out")
            
            if Auth.auth().currentUser == nil {
                
                // Need to return to HomeVC view so that it looks normal when re-entering
                
                let loginController = RegistrationVC()
                let navContoller = UINavigationController(rootViewController: loginController)
                self.present(navContoller, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(settingsAction)
        actionSheet.addAction(logoutAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleAdd() {
        let addSongController = AddSongVC()
        addSongController.user = self.user
        present(addSongController, animated: true)
    }
    
}

class FooterView: UIView {
    
    let searchIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "searchColor"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let addIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "addColor"), for: .normal)
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
        
        searchIcon.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: -25, paddingRight: 0, width: 30, height: 30)
        addIcon.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -25, paddingRight: 20, width: 30, height: 30)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

