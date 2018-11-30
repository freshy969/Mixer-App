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
    let likeButton = PostActionButtonView()
    let addButton = PostActionButtonView()
    let queueButton = OffCenteredButtonView()
    let playButton = OffCenteredButtonView()
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLabelComponents() {
        usernameButtonLabel.textColor = UIColor.lightGray
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
        
        likeButton.buttonIcon.setImage(UIImage(named: "heartWhiteUnfilled"), for: .normal)
        addButton.buttonIcon.setImage(UIImage(named: "addWhiteUnfilled")?.withRenderingMode(.alwaysOriginal), for: .normal)
        queueButton.buttonIcon.setImage(UIImage(named: "queueWhiteUnfilled")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.buttonIcon.setImage(UIImage(named: "playButtonWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        profilePictureButton.contentMode = .scaleAspectFit
        profilePictureButton.layer.cornerRadius = 10
        profilePictureButton.clipsToBounds = true
        
        albumImage.layer.cornerRadius = 20.0
        albumImage.layer.masksToBounds = true
        albumImage.clipsToBounds = true
        albumImage.layer.shadowRadius = 10
        albumImage.layer.shadowOpacity = 0.6
        albumImage.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func setupCardComponents() {
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.white
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func applyAverageColor() {
        //let gradient = getCircleGradient() // function is currently way too slow to use
        let averageColorFromImage = AverageColorFromImage(image: albumImage.image!)
        
        likeButton.backgroundColor = averageColorFromImage
        addButton.backgroundColor = averageColorFromImage
        queueButton.backgroundColor = averageColorFromImage
        playButton.backgroundColor = averageColorFromImage
        // profilePictureButton.backgroundColor = averageColorFromImage
    }
    
    fileprivate func setupStackView() {
        
        let userArrangedSubviews = [SpacerViewHeight(space: 1),
                                    usernameButtonLabel,
                                    playlistNameButtonLabel]
        let userInfoStackView = UIStackView(arrangedSubviews: userArrangedSubviews)
        userInfoStackView.spacing = 1
        userInfoStackView.axis = .vertical

        let topArrangedSubview = [userInfoStackView, UIView(), profilePictureButton]
        let topStackView = UIStackView(arrangedSubviews: topArrangedSubview)
        topStackView.spacing = 1
        
        let albumImageArrangedSubview = [SpacerViewWidth(space: 25), albumImage, SpacerViewWidth(space: 25)]
        let albumStackView = UIStackView(arrangedSubviews: albumImageArrangedSubview)
        albumStackView.spacing = 1
        albumStackView.distribution = .fillProportionally

        let arrangedSubviewWithAlbum = [topStackView,
                                        SpacerViewHeight(space: 33.5),
                                        albumStackView,
                                        UIView()]
        let stackViewWithAlbum = UIStackView(arrangedSubviews: arrangedSubviewWithAlbum)
        stackViewWithAlbum.axis = .vertical
        stackViewWithAlbum.spacing = 1

        let arrangedSubviewOfActionButtons = [likeButton, SpacerViewWidth(space: 4), addButton, SpacerViewWidth(space: 4), queueButton, UIView()]
        let stackViewOfActionButtons = UIStackView(arrangedSubviews: arrangedSubviewOfActionButtons)
        stackViewOfActionButtons.spacing = 1

        let bottomLeftSubview = [songNameButtonLabel,
                                              artistNameButtonLabel,
                                              SpacerViewHeight(space: 5),
                                              stackViewOfActionButtons]
        let bottomLeftStackView = UIStackView(arrangedSubviews: bottomLeftSubview)
        bottomLeftStackView.axis = .vertical
        bottomLeftStackView.spacing = 1
        
        let bottomRightArrangedSubview = [UIView(), playButton]
        let bottomRightStackView = UIStackView(arrangedSubviews: bottomRightArrangedSubview)
        bottomRightStackView.axis = .vertical
        bottomRightStackView.spacing = 1
        
        let bottomArrangedSubview = [bottomLeftStackView, UIView(), bottomRightStackView]
        let bottomStackView = UIStackView(arrangedSubviews: bottomArrangedSubview)
        bottomStackView.spacing = 1
        // bottomStackView.distribution = .fillProportionally
        
        let arrangedSubviewOfPost = [stackViewWithAlbum,
                                     bottomStackView]
        let postStackView = UIStackView(arrangedSubviews: arrangedSubviewOfPost)
        postStackView.axis = .vertical
        self.addSubview(postStackView)
        postStackView.translatesAutoresizingMaskIntoConstraints = false
        postStackView.spacing = 1
        postStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        postStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        postStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        postStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        postStackView.isLayoutMarginsRelativeArrangement = true
        postStackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)

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
