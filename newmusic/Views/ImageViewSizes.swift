//
//  ProfileImageView.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/28/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class ImageViewSizes: UIImageView {
    // this file holds many size constraints for the app
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 0)
    }
}

class MenuProfileImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 54, height: 54)
    }
}

class PostProfileImageView: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

class PlaylistProfileImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}

class AlbumImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 235, height: 235)
    }
}

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

class AddOtherPlaylistActionButtonImageView: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 10)
    }
}


