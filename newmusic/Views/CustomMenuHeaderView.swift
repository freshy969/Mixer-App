//
//  CustomMenuHeaderView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/28/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = MenuProfileImageView()
    
    let settingsButton: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "settingsColor"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupComponentProps()
        setupHeaderView()
    }
    
    fileprivate func setupComponentProps() {
        nameLabel.text = "Joe Langenderfer"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        usernameLabel.text = "@joelangenderfer".lowercased()
        statsLabel.text = "42 Following 7091 Followers"
        profileImageView.image = UIImage(named: "joe")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 54 / 2
        profileImageView.clipsToBounds = true
        
        
        setupStatsAttributedText()
    }
    
    fileprivate func setupStatsAttributedText() {
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupHeaderView() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(statsLabel)
        addSubview(settingsButton)
        
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12.5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        usernameLabel.anchor(top: nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        statsLabel.anchor(top: usernameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        settingsButton.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 12.5, width: 30, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
