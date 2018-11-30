////
////  ViewController.swift
////  newmusic
////
////  Created by Joe Langenderfer on 11/16/18.
////  Copyright © 2018 Joe Langenderfer. All rights reserved.
////
//
//import UIKit
//
//class OldHomeVC: UIViewController, UIGestureRecognizerDelegate {
//
//    @IBOutlet var tableView: UITableView!
//
//    var profilePic = "joe"
//    var username = "joelangenderfer" // Must capitalize
//    var playlistNameArray = ["Coding Jams", "Pregame Songs", "Cheery EDM", "Chillout Vibes", "My Top 10", "Chillout Vibes"]
//    var songArray = ["Divide", "No Problem", "Winnebago", "Say My Name", "Closer (Remix)", "Loyal"]
//    var artistArray = ["Odesza", "Chance the Rapper", "Gryffin", "Odesza", "The Chainsmokers", "Odesza"]
//    var albumCoverArray = ["odesza", "chance", "winn", "odesza2", "chainsmokers", "odesza3"]
//
//    let menuController = MenuVC()
//    var lastContentOffset: CGFloat = 0
//    fileprivate let menuWidth: CGFloat = 300
//    fileprivate var isMenuOpened = false
//    fileprivate var tableViewIsScrolling = false
//    fileprivate let velocityOpenThreshold: CGFloat = 800
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//
//        setupNavigationBarItems()
//        setupMenuController()
//
//        setupPanGesture()
//        setupCoverView()
//    }
//
//    let coverView = UIView()
//
//    fileprivate func setupCoverView() {
//        coverView.alpha = 0
//        coverView.backgroundColor = UIColor(white: 1, alpha: 0.75)
//        // navigationController?.view.addSubview(coverView)
//        // coverView.frame = view.frame
//        coverView.isUserInteractionEnabled = false
//        let mainWindow = UIApplication.shared.keyWindow
//        mainWindow?.addSubview(coverView)
//        coverView.frame = mainWindow?.frame ?? .zero
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        menuController.view.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
//    }
//
//    @objc func handlePan(gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: view)
//
//        if gesture.state == .changed {
//            var x = translation.x
//
//            if isMenuOpened {
//                x += menuWidth
//            }
//
//            x = min(menuWidth, x)
//            x = max(0, x)
//
//            let transform = CGAffineTransform(translationX: x, y: 0)
//            menuController.view.transform = transform
//            navigationController?.view.transform = transform
//            coverView.transform = transform
//
//            coverView.alpha = x / menuWidth
//
//        } else if gesture.state == .ended {
//            handleEnded(gesture: gesture)
//        }
//    }
//
//    @objc func handleOpen() {
//        isMenuOpened = true
//        performAnimations(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
//    }
//
//    @objc func handleHide() {
//        isMenuOpened = false
//        performAnimations(transform: .identity)
//        // menuController.view.removeFromSuperview()
//        // menuController.removeFromParent()
//    }
//
//    // MARK:- Fileprivate
//
//    fileprivate func setupNavigationBarItems() {
//        navigationItem.title = "Your New Music"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
//        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]
//    }
//
//    fileprivate func setupMenuController() {
//        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
//        let mainWindow = UIApplication.shared.keyWindow
//        // UIApplication gives us a simpleton to be able to access the current object of the application
//        mainWindow?.addSubview(menuController.view)
//        addChild(menuController)
//    }
//
//    fileprivate func performAnimations(transform: CGAffineTransform) {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            // final position to animate menuController object
//            self.menuController.view.transform = transform
//            self.navigationController?.view.transform = transform
//            self.coverView.transform = transform
//
//            self.coverView.alpha = transform == .identity ? 0 : 1
//        })
//    }
//
//    fileprivate func setupPanGesture() {
//        // Pan Gesture
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        panGesture.delegate = self
//        view.addGestureRecognizer(panGesture)
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: view)
//
//        let velocity = gesture.velocity(in: view)
//
//        if isMenuOpened {
//            if abs(velocity.x) > velocityOpenThreshold {
//                handleHide()
//                return
//            }
//
//            if abs(translation.x) < menuWidth / 2 {
//                handleOpen()
//            } else {
//                handleHide()
//            }
//        } else {
//            if velocity.x > velocityOpenThreshold {
//                handleOpen()
//                return
//            }
//
//            if translation.x < menuWidth/2 {
//                handleHide()
//            } else {
//                handleOpen()
//            }
//        }
//    }
//}
//
//
//extension OldHomeVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return songArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as! TimelineTableViewCell
//        cell.selectionStyle = .none
//        cell.setupComponentProps()
//        cell.usernameButtonLabel.setTitle("@" + username.uppercased(), for: .normal)
//        cell.playlistNameButtonLabel.setTitle(playlistNameArray[indexPath.row].capitalized, for: .normal)
//        cell.songNameButtonLabel.setTitle(songArray[indexPath.row], for: .normal)
//        cell.artistNameButtonLabel.setTitle(artistArray[indexPath.row], for: .normal)
//        cell.albumImage.image = UIImage(named: albumCoverArray[indexPath.row])
//        cell.applyAverageColor()
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
//}
