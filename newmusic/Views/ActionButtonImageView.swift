//
//  ActionButtonImageView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/29/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class ActionButtonImageView: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 14, height: 14)
    }
}

class ActionButtonBackgroundView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: 30)
    }
}

