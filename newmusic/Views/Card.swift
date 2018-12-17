//
//  Card.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/29/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import ChameleonFramework
import CoreMotion

class Card: UIView {

    private let motionManager = CMMotionManager()
    private var longPressGestureRecognizer: UILongPressGestureRecognizer? = nil
    private var isPressed: Bool = false
    private weak var shadowView: UIView?

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
        configureGestureRecognizer()
        setupGradientLayer()
//        setupPlaylistTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLabelComponents() {
        usernameButtonLabel.textColor = UIColor.white
        usernameButtonLabel.textAlignment = .left
        usernameButtonLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        // make sure it is uppercased in HomeVC
        
        playlistNameButtonLabel.textColor = UIColor.white
        playlistNameButtonLabel.textAlignment = .left
        playlistNameButtonLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        // make sure it is capitalized in HomeVC
        
        songNameButtonLabel.textColor = UIColor.white
        songNameButtonLabel.textAlignment = .left
        songNameButtonLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        artistNameButtonLabel.textColor = UIColor.white
        artistNameButtonLabel.textAlignment = .left
        artistNameButtonLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        likeTotalButtonLabel.textColor = UIColor.white
        likeTotalButtonLabel.textAlignment = .right
        likeTotalButtonLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }

    fileprivate func setupButtonComponents() {
        
        addButton.buttonIcon.setImage(UIImage(named: "addWhiteUnfilled"), for: .normal)
        queueButton.buttonIcon.setImage(UIImage(named: "queueWhiteUnfilled")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sendButton.buttonIcon.setImage(UIImage(named: "sendWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.buttonIcon.setImage(UIImage(named: "playButtonWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        profilePictureButton.contentMode = .scaleAspectFit
        profilePictureButton.layer.cornerRadius = 48 / 2
        profilePictureButton.clipsToBounds = true
        
        albumImage.layer.cornerRadius = 14
        albumImage.layer.masksToBounds = true
        albumImage.clipsToBounds = true
        albumImage.layer.shadowRadius = 10
        albumImage.layer.shadowOpacity = 0.35
//        albumImage.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func setupCardComponents() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor.white
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.35
        self.layer.shadowColor = UIColor.black.cgColor
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
        
//        usernameButtonLabel.textColor = averageColorFromImage
        addButton.backgroundColor = averageColorFromImage
        queueButton.backgroundColor = averageColorFromImage
        sendButton.backgroundColor = averageColorFromImage
        playButton.backgroundColor = averageColorFromImage
         profilePictureButton.backgroundColor = averageColorFromImage
//        self.layer.shadowColor = averageColorFromImage.cgColor
        albumImage.layer.shadowColor = averageColorFromImage.cgColor
    }
    
    fileprivate func setupStackView() {
        
        addSubview(albumImage)
        addSubview(songNameButtonLabel)
        addSubview(usernameButtonLabel)
        addSubview(playlistNameButtonLabel)
        addSubview(profilePictureButton)
        addSubview(artistNameButtonLabel)
        addSubview(addButton)
        addSubview(queueButton)
        addSubview(sendButton)
        addSubview(likeTotalButtonLabel)
        addSubview(playButton)
        
        sendSubviewToBack(albumImage)
        
        albumImage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profilePictureButton.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 10, paddingRight: 50, width: 48, height: 48)
        usernameButtonLabel.anchor(top: self.topAnchor, left: profilePictureButton.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 245, height: 16)
        songNameButtonLabel.anchor(top: usernameButtonLabel.bottomAnchor, left: profilePictureButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 245, height: 16)
        artistNameButtonLabel.anchor(top: songNameButtonLabel.bottomAnchor, left: profilePictureButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 245, height: 16)
//        playlistNameButtonLabel.anchor(top: usernameButtonLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 50, width: 246, height: 27)
        addButton.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: -15, paddingRight: 5, width: 35, height: 35)
        queueButton.anchor(top: nil, left: addButton.rightAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: -15, paddingRight: 5, width: 35, height: 35)
        sendButton.anchor(top: nil, left: queueButton.rightAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: -15, paddingRight: 5, width: 35, height: 35)
//        likeTotalButtonLabel.anchor(top: albumImage.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 48, paddingLeft: 5, paddingBottom: 0, paddingRight: 20, width: 70, height: 17)
        playButton.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -15, paddingRight: 20, width: 35, height: 35)

    }
    
    // MARK: - Gesture Recognizer
    
    private func configureGestureRecognizer() {
        // Long Press Gesture Recognizer
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gestureRecognizer:)))
        longPressGestureRecognizer?.minimumPressDuration = 0.1
        addGestureRecognizer(longPressGestureRecognizer!)
    }
    
    @objc internal func handleLongPressGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            handleLongPressBegan()
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            handleLongPressEnded()
        }
    }
    
    private func handleLongPressBegan() {
        guard !isPressed else {
            return
        }
        
        isPressed = true
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    private func handleLongPressEnded() {
        guard isPressed else {
            return
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform.identity
        }) { (finished) in
            self.isPressed = false
        }
    }
    
    let gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [-0.85, 1.40]
        gradientLayer.cornerRadius = 14
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        albumImage.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }

}
