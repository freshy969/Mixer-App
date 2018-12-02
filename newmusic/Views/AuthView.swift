//
//  AuthView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/1/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class AuthView: UIView {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "NewMusicLogoWhite")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up to share your favorite"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let appDescriptionLine2Label: UILabel = {
        let label = UILabel()
        label.text = "songs with your friends."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let enterUsername: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        return tf
    }()
    
    let enterPassword: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        return tf
    }()
    
    let whiteSeparatorLine: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let signUpButton = SignUpButtonView()
    
    let bottomQuestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAuthView()
//        backgroundColor = UIColor.rgb(red: 6, green: 28, blue: 61)
        self.translatesAutoresizingMaskIntoConstraints = false
        addBackground()
        setupStatsAttributedText()
    }
    
    fileprivate func setupAuthView() {
        
        self.addSubview(logoImageView)
        self.addSubview(appDescriptionLabel)
        self.addSubview(appDescriptionLine2Label)
        
        logoImageView.anchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        logoImageView.centerXAnchor.constraint(lessThanOrEqualTo: logoImageView.superview!.centerXAnchor).isActive = true
        setupAuthComponents()
        
        appDescriptionLabel.anchor(top: logoImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 50, height: 24)
        appDescriptionLine2Label.anchor(top: appDescriptionLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 50, height: 24)
    }
    
    fileprivate func setupAuthComponents() {
        self.addSubview(enterUsername)
        self.addSubview(enterPassword)
        self.addSubview(whiteSeparatorLine)
        self.addSubview(signUpButton)
        self.addSubview(bottomQuestionLabel)
        
        enterUsername.anchor(top: appDescriptionLine2Label.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 24)
        whiteSeparatorLine.anchor(top: enterUsername.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        enterPassword.anchor(top: whiteSeparatorLine.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 24)
        signUpButton.anchor(top: enterPassword.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 60)
        bottomQuestionLabel.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: -40, paddingRight: 40, width: 50, height: 20)
    }
    
    fileprivate func setupStatsAttributedText() {
        bottomQuestionLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        attributedText.append(NSAttributedString(string: "Sign In.", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .heavy)]))
        bottomQuestionLabel.attributedText = attributedText
    }
    
    func addBackground() {
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: "midnightGradientBackground")
        imageViewBackground.contentMode = .scaleAspectFill
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
        
        imageViewBackground.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 800)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
