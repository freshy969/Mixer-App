//
//  Card.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/29/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import ChameleonFramework

class Card: UIView {

    let albumImage = AlbumImageView()
    let addButton = PostActionButtonView()
    let queueButton = OffCenteredActionButtonView()
    let sendButton = PostActionButtonView()
    let playButton = OffCenteredActionButtonView()
    
    let profilePictureButton = PostProfileImageView()
    
    let usernameButtonLabel = UILabel()
    let playlistNameButtonLabel = UILabel()
    let songNameButtonLabel = UILabel()
    let artistNameButtonLabel = UILabel()
    let likeTotalButtonLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardComponents()
        setupLabelComponents()
        setupButtonComponents()
        setupStackView()
//        setupPlaylistTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLabelComponents() {
//        usernameButtonLabel.textColor = UIColor.lightGray
        usernameButtonLabel.textAlignment = .left
        usernameButtonLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)

        // make sure it is uppercased in HomeVC
        
        playlistNameButtonLabel.textColor = UIColor.darkGray
        playlistNameButtonLabel.textAlignment = .left
        playlistNameButtonLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        // make sure it is capitalized in HomeVC
        
        songNameButtonLabel.textColor = UIColor.darkGray
        songNameButtonLabel.textAlignment = .left
        songNameButtonLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        artistNameButtonLabel.textColor = UIColor.lightGray
        artistNameButtonLabel.textAlignment = .left
        artistNameButtonLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        likeTotalButtonLabel.textColor = UIColor.lightGray
        likeTotalButtonLabel.textAlignment = .right
        likeTotalButtonLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }

    fileprivate func setupButtonComponents() {
        
        addButton.buttonIcon.setImage(UIImage(named: "addWhiteUnfilled"), for: .normal)
        queueButton.buttonIcon.setImage(UIImage(named: "queueWhiteUnfilled")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sendButton.buttonIcon.setImage(UIImage(named: "sendWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.buttonIcon.setImage(UIImage(named: "playButtonWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        profilePictureButton.contentMode = .scaleAspectFit
        profilePictureButton.layer.cornerRadius = 10
        profilePictureButton.clipsToBounds = true
        
        albumImage.layer.cornerRadius = 20.0
        albumImage.layer.masksToBounds = true
        albumImage.clipsToBounds = true
        albumImage.layer.shadowRadius = 10
        albumImage.layer.shadowOpacity = 0.6
//        albumImage.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func setupCardComponents() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.white
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
//    func setupPlaylistTapGesture() { // will need to take a string (playlist name) and open that playlist
//        playlistNameButtonLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPlaylist)))
//    }
//
//    @objc fileprivate func openPlaylist() {
//        let playlistController = PlaylistDetailVC()
//        let navContoller = UINavigationController(rootViewController: playlistController)
//        navigationController?.pushViewController(navContoller, animated: true)
//    }
    
    func applyAverageColor() {
        //let gradient = getCircleGradient() // function is currently way too slow to use
        let averageColorFromImage = AverageColorFromImage(image: albumImage.image!)
        
        usernameButtonLabel.textColor = averageColorFromImage
        addButton.backgroundColor = averageColorFromImage
        queueButton.backgroundColor = averageColorFromImage
        sendButton.backgroundColor = averageColorFromImage
        playButton.backgroundColor = averageColorFromImage
         profilePictureButton.backgroundColor = averageColorFromImage
//        self.layer.shadowColor = averageColorFromImage.cgColor
        albumImage.layer.shadowColor = averageColorFromImage.cgColor
    }
    
    fileprivate func setupStackView() {
        
        addSubview(usernameButtonLabel)
        addSubview(playlistNameButtonLabel)
        addSubview(profilePictureButton)
        addSubview(albumImage)
        addSubview(songNameButtonLabel)
        addSubview(artistNameButtonLabel)
        addSubview(addButton)
        addSubview(queueButton)
        addSubview(sendButton)
        addSubview(likeTotalButtonLabel)
        addSubview(playButton)
        
        usernameButtonLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 20, paddingBottom: 10, paddingRight: 50, width: 246, height: 17)
        playlistNameButtonLabel.anchor(top: usernameButtonLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 50, width: 246, height: 27)
        profilePictureButton.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 20, width: 48, height: 48)
        albumImage.anchor(top: playlistNameButtonLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 27.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 225, height: 225)
        albumImage.centerXAnchor.constraint(lessThanOrEqualTo: albumImage.superview!.centerXAnchor).isActive = true
        songNameButtonLabel.anchor(top: albumImage.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 27.5, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 241, height: 17)
        artistNameButtonLabel.anchor(top: songNameButtonLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 241, height: 17)
        addButton.anchor(top: artistNameButtonLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 20, paddingBottom: 20, paddingRight: 5, width: 30, height: 30)
        queueButton.anchor(top: artistNameButtonLabel.bottomAnchor, left: addButton.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 5, paddingBottom: 20, paddingRight: 5, width: 30, height: 30)
        sendButton.anchor(top: artistNameButtonLabel.bottomAnchor, left: queueButton.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 5, paddingBottom: 20, paddingRight: 5, width: 30, height: 30)
        likeTotalButtonLabel.anchor(top: albumImage.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 45, paddingLeft: 5, paddingBottom: 0, paddingRight: 20, width: 70, height: 17)
        playButton.anchor(top: likeTotalButtonLabel.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 7.5, paddingLeft: 5, paddingBottom: 20, paddingRight: 20, width: 30, height: 30)

    }

    
    func animateImage() { // call during seugue ?
        // perform animation for card when tapped
        // must add gesture recognizer to the view of the card
        // guessing will want to disable the gray thing from tapping on a cell too
    }
    
    //    func getCircleGradient() -> UIColor {
    //        let prominentColors = ColorsFromImage(image: albumImage.image!, withFlatScheme: true)
    //        let circlesGradient = GradientColor(gradientStyle: UIGradientStyle.radial, frame: CGRect(x: 0, y: 0, width: 30, height: 30), colors: prominentColors)
    //        return circlesGradient
    //    }

}
