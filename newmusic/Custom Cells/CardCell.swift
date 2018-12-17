//
//  CardCell.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/15/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import CoreMotion

class CardCell: NewsfeedCollectionViewCell {
    
    var card = Card()
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CardCell {
        guard let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {
            fatalError("*** Failed to dequeue CardCell ***")
        }
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    fileprivate func setupCard() {
        addSubview(card)
        card.frame.size = CGSize(width: 290.0, height: 318.0)
//        card.clipsToBounds = true
//        card.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 450)
    }
}
