//
//  AlbumCollageView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/2/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class AlbumCollageView: UIView {
    
    // put them all in here with the right sizes, then aspect fill the header background view in the headerview
    
    var albumCover1: UIImageView = {
        let iv = PlaylistAlbumCollageRightView()
        iv.image = UIImage(named: "odesza")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var albumCover2: UIImageView = {
        let iv = PlaylistAlbumCollageRightView()
        iv.image = UIImage(named: "chainsmokers")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var albumCover3: UIImageView = {
        let iv = PlaylistAlbumCollageRightView()
        iv.image = UIImage(named: "chance")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var leftAlbumCover: UIImageView = {
        let iv = PlaylistAlbumCollageLeftView()
        iv.image = UIImage(named: "winn")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAlbumCollage()
        setupGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupAlbumCollage() {
        let stackView = UIStackView(arrangedSubviews: [
            albumCover1,
            albumCover2,
            albumCover3
            ])
        addSubview(stackView)
        addSubview(leftAlbumCover)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        leftAlbumCover.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: stackView.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stackView.anchor(top: self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 0)
        
        
        // need to fix the height at 275
    }
    
    let gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
}
