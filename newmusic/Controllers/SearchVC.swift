//
//  SearchVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/1/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let quitIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "quitBlack"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handleQuit), for: .touchUpInside)
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            
        navigationItem.searchController = UISearchController(searchResultsController: nil)
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Search"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)
        
        view.addSubview(quitIcon)
        quitIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
    }
    
    @objc fileprivate func handleQuit() {
        dismiss(animated: true, completion: nil)
    }

}
