//
//  TimelineTableViewCell.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/26/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import ChameleonFramework

class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var queueButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    
    func setupCardUI() {
        
        //let gradient = getCircleGradient() // function is currently way too slow to use
        
        let averageColorFromImage = AverageColorFromImage(image: albumImage.image!)
        
        likeButton.layer.cornerRadius = likeButton.frame.size.width / 2
        likeButton.clipsToBounds = true
        likeButton.backgroundColor = averageColorFromImage
        
        addButton.layer.cornerRadius = likeButton.frame.size.width / 2
        addButton.clipsToBounds = true
        addButton.backgroundColor = averageColorFromImage
        
        queueButton.layer.cornerRadius = likeButton.frame.size.width / 2
        queueButton.clipsToBounds = true
        queueButton.backgroundColor = averageColorFromImage
        
        playButton.layer.cornerRadius = likeButton.frame.size.width / 2
        playButton.clipsToBounds = true
        playButton.backgroundColor = averageColorFromImage
        
        userButton.layer.cornerRadius = likeButton.frame.size.width / 2
        userButton.clipsToBounds = true
        userButton.backgroundColor = averageColorFromImage
        
        albumImage.layer.cornerRadius = 20
        albumImage.clipsToBounds = true
        albumImage.layer.shadowRadius = 10
        albumImage.layer.shadowOpacity = 0.6
        albumImage.layer.shadowColor = UIColor.gray.cgColor
        
        card.layer.cornerRadius = 20
        card.backgroundColor = UIColor.white
        card.layer.shadowRadius = 10
        card.layer.shadowOpacity = 0.6
        card.layer.shadowColor = UIColor.gray.cgColor
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
