//
//  PlaylistDetailView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/2/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class CustomPlaylistHeaderView: UIView {

    // three equally proportioned, scaleaspect fit vertical stack view anchored to top, left and bottom and album on the right.
    // Album anchored to the right must be of a fixed square size
    
    var albumCollage: UIView = {
        let iv = AlbumCollageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let profileImageView: UIImageView = {
        let iv = PlaylistProfileImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 100 / 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let playlistName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "My Top 10"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let playlistDesc: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "A Playlist by Joe Langenderfer".uppercased()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        placeAlbumCollage()
        setupHeaderComponents()
    }
    
    fileprivate func placeAlbumCollage() {
        addSubview(albumCollage)
        sendSubviewToBack(albumCollage)
        
        albumCollage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 275)
    }
    
    fileprivate func setupHeaderComponents() {
        addSubview(profileImageView)
        
        let stackView = UIStackView(arrangedSubviews: [
            playlistName,
            playlistDesc
            ])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 4

        profileImageView.anchor(top: albumCollage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: -40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
