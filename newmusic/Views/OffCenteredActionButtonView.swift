//
//  offCenteredButtonView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/29/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class OffCenteredActionButtonView: UIView {
    
    let buttonIcon = ActionButtonImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewComponents()
        setupButtonComponents()
        placeButton()
    }
    
    func setupViewComponents() {
        self.layer.cornerRadius = 35 / 2
        self.clipsToBounds = true
    }
    
    func setupButtonComponents() {
        buttonIcon.contentMode = .scaleAspectFit
        buttonIcon.clipsToBounds = true
    }
    
    func placeButton() {
        
        let stackView = UIStackView(arrangedSubviews: [buttonIcon])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
