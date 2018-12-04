//
//  PlaylistDetailTableViewCell.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/2/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class PlaylistDetailTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.textLabel?.text = ""

        // Configure the view for the selected state
    }

}
