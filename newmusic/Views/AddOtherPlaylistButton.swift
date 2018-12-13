//
//  AddOtherPlaylistButton.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/13/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class OtherPlaylistButton: UIView {
    
    let otherPlaylistLabel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Other Playlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return button
    }()
    
    let downIcon = AddOtherPlaylistActionButtonImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupIcon()
        
        self.backgroundColor = UIColor.lightText
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 22
        
        let stackView = UIStackView(arrangedSubviews: [otherPlaylistLabel, downIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
//        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        stackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 10)
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    fileprivate func setupIcon() {
        downIcon.setImage(UIImage(named: "downArrowWhite"), for: .normal)
        downIcon.contentMode = .scaleAspectFit
        downIcon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
