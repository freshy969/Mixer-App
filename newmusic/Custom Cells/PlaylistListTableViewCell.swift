//
//  PlaylistListTableViewCell.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/12/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class PlaylistListTableViewCell: UITableViewCell {
    
    let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playlistSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let stackView = UIStackView(arrangedSubviews: [
            playlistNameLabel,
            playlistSubtitleLabel
            ])
        
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.anchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 300, height: 40)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        // Configure the view for the selected state
    }

}
