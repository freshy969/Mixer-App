//
//  TimelineTableViewCell.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/26/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    var card = Card()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCard() {
        addSubview(card)
        
        card.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 435)
    }
}
