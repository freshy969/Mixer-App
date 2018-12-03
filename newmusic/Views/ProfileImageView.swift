//
//  ProfileImageView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/28/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class ImageViewSizes: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 54, height: 54)
    }
}

ImageViewSizes

class PlaylistAlbumCollageRightView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 80)
    }
}

class PlaylistAlbumCollageLeftView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 275, height: 275)
    }
}

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

class PostProfileImageView: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

class AlbumImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 235, height: 235)
    }
    
}



