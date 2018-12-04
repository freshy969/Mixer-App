//
//  PlaylistDetailTableViewCell.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/2/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class PlaylistDetailTableViewCell: UITableViewCell {
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "" // dont forget to add numbers
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        //uppercase this
        
        let label = UILabel()
        label.text = "" // dont forget to add numbers
        label.textColor = .black
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [songNameLabel, artistNameLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 150, height: 40)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
