//
//  ViewController.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/16/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class TimelineVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var songArray = ["Divide"]
    var playlistNameArray = ["Coding Tunes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
        navigationItem.title = "Your Newmusic"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]
    }
}

extension TimelineVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as! TimelineTableViewCell
        cell.setupCardUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}


