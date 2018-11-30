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
    
    // now need to place the card in a certain position in the cell
    fileprivate func setupCard() {
        let stackView = UIStackView(arrangedSubviews: [card])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 20, bottom: 25, right: 20)
    }
}
