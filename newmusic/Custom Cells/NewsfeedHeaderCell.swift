//
//  NewsfeedHeaderView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/17/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class NewsfeedHeaderCell: UITableViewCell {

    let welcomeTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.text = "".uppercased()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.text = "Your New Music"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let customView = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    fileprivate func setupComponents() {
        addSubview(welcomeTitle)
        addSubview(title)
        addSubview(customView)
        
        welcomeTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 200, height: 14)
        title.anchor(top: welcomeTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 200, height: 38)
        customView.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 35, height: 35)
    }
}
