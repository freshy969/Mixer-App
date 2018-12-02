//
//  SignUpButtonView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/1/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class SignUpButtonView: UIView {
    
    let signUpButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.frame.size = CGSize(width: 40, height: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(signUpButtonLabel)
        
        signUpButtonLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        signUpButtonLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        signUpButtonLabel.textAlignment = .center
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 30
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
