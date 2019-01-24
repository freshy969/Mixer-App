//
//  SelectMusicProviderVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 1/23/19.
//  Copyright © 2019 Joe Langenderfer. All rights reserved.
//

import UIKit

class SelectMusicProviderVC: UIViewController {
    
    let quitIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "quitBlack"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handleQuit), for: .touchUpInside)
        return iv
    }()
    
    let selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Music Provider"
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let appleMusicView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "appleMusicBadge")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        iv.heightAnchor.constraint(equalToConstant: 75).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(selectLabel)
        view.addSubview(appleMusicView)
        view.addSubview(quitIcon)
        
        selectLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 125, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        selectLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        appleMusicView.anchor(top: selectLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        appleMusicView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        quitIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)

    }
    
    @objc fileprivate func handleQuit() {
        dismiss(animated: true, completion: nil)
    }
    
}

