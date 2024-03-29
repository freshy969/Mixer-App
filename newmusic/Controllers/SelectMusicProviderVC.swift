//
//  SelectMusicProviderVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 1/23/19.
//  Copyright © 2019 Joe Langenderfer. All rights reserved.
//

import UIKit
import Foundation
import StoreKit
import MediaPlayer

@available(iOS 10.3, *)
class SelectMusicProviderVC: UIViewController {
    
    let quitIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "dark-close-button"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handleQuit), for: .touchUpInside)
        return iv
    }()
    
    let selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Music Provider"
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let appleMusicView: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "appleMusicBadge"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handleAppleMusic), for: .touchUpInside)
        iv.heightAnchor.constraint(equalToConstant: 75).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(selectLabel)
        view.addSubview(appleMusicView)
        view.addSubview(quitIcon)
        
        selectLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 125, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        selectLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        appleMusicView.anchor(top: selectLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        appleMusicView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        quitIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 27.5, height: 27.5)

    }
    
    @objc fileprivate func handleAppleMusic() {
        print("Apple Music Clicked")
        authorizeAppleMusic()
        
        guard SKCloudServiceController.authorizationStatus() == .authorized else {
            print("Not Authorized")
            return
        }
        
        moreInformation()
    }
    
    fileprivate func moreInformation() {
        
        let appleMusicManager = AppleMusicManager()
        let authorizationManager = AuthorizationManager(appleMusicManager: appleMusicManager)
        
        let controller = SKCloudServiceController()
        controller.requestCapabilities(completionHandler: { (cloudServiceCapability, error) in
            guard error == nil else {
                print("ERROR- Could not get more information about Apple Music Capability")
                return
                // Handle Error accordingly, see SKError.h for error codes.
            }
            
            if authorizationManager.cloudServiceCapabilities.contains(.addToCloudMusicLibrary) {
                // The application can add items to the iCloud Music Library.
                print("1")
            }
            
            if authorizationManager.cloudServiceCapabilities.contains(.musicCatalogPlayback) {
                // The application can playback items from the Apple Music catalog.
                print("2")
            }
            
            if authorizationManager.cloudServiceCapabilities.contains(.musicCatalogSubscriptionEligible) {
                // The iTunes Store account is currently elgible for and Apple Music Subscription trial.
                print("3")
            }
        })
    }
    
    fileprivate func authorizeAppleMusic() {
        
        let appleMusicManager = AppleMusicManager()
        let authorizationManager = AuthorizationManager(appleMusicManager: appleMusicManager)
        
        guard SKCloudServiceController.authorizationStatus() == .notDetermined else {
            print("Status Already Determined")
            return
        }
        
        SKCloudServiceController.requestAuthorization { (authorizationStatus) in
            switch authorizationStatus {
            case .authorized:
                authorizationManager.requestCloudServiceCapabilities()
//                authorizationManager.requestUserToken()
                // Don't need this right now for search
            default:
                break
            }
            
            NotificationCenter.default.post(name: AuthorizationManager.authorizationDidUpdateNotification, object: nil)
        }
        print("Status Determined")
        print(SKCloudServiceController.authorizationStatus())
    }
    
    @objc fileprivate func handleQuit() {
        dismiss(animated: true, completion: nil)
    }
}

