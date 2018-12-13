//
//  BaseSlidingVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/29/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class CoverView: UIView {}

class BaseSlidingVC: UIViewController, LoginControllerDelegate {
    
    var user: MusicUser!
    
    let redView: RightContainerView = {
        let v = RightContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: MenuContainerView = {
        let v = MenuContainerView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let coverView: CoverView = {
        let v = CoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.15)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismissed))
        coverView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentUser()
    
    }
    
    func getCurrentUser() {
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            let loginController = RegistrationVC()
            let navContoller = UINavigationController(rootViewController: loginController)
            self.present(navContoller, animated: true)
        }
        else {
            user = MusicUser(user: currentUser!)
        }
    }
    
    func didFinishLoggingIn() {
        // fetch user data here
    }

    @objc fileprivate func handleTapDismissed() {
        closeMenu()
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    fileprivate let velocityOpenThreshold: CGFloat = 800
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
        coverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if velocity.x < -velocityOpenThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if velocity.x > velocityOpenThreshold {
                openMenu()
                return
            }
            
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        performAnimations()
    }
    
    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        
        performRightViewCleanup()
        closeMenu()

        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeVC())
        case 1:
            rightViewController = UINavigationController(rootViewController: TopTenPlaylistVC())
        case 2:
            rightViewController = UINavigationController(rootViewController: HotTenPlaylistVC())
        case 3:
            rightViewController = UINavigationController(rootViewController: PlaylistListVC())
        default:
            rightViewController = UINavigationController(rootViewController: QueueListVC())
//        case 5:
//            rightViewController = UINavigationController(rootViewController: SearchVC())
//        default:
//            let tabBarController = UITabBarController()
//            let addSongController = AddSongVC()
//            tabBarController.viewControllers = [addSongController]
//            rightViewController = tabBarController
//            tabBarItem.title = "Add Song"
            
        }

        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        redView.bringSubviewToFront(coverView)
    }
    
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeVC())
    
    fileprivate func performRightViewCleanup() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.coverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        // Auto-Layout
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth)
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        redViewTrailingConstraint.isActive = true
        
        setupViewController()
        
    }
    
    func setupViewController() {
        let menuController = DetailMenuVC()
        
        let homeView = rightViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(coverView)
        blueView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            coverView.topAnchor.constraint(equalTo: redView.topAnchor),
            coverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            coverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            coverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            ])
        
        addChild(rightViewController)
        addChild(menuController)
    }
}
