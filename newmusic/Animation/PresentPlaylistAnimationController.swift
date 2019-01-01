//
//  PresentPlaylistAnimationController.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/20/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class PresentPlaylistAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var selectedCardFrame: CGRect = .zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? HomeVC,
            let toViewController = transitionContext.viewController(forKey: .to) as? NewsfeedDetailViewController else {
                return
        }
        
        // 2
        containerView.addSubview(toViewController.view)
        toViewController.positionContainer(left: 20.0,
                                           right: 20.0,
                                           top: selectedCardFrame.origin.y + 20.0,
                                           bottom: 0.0)
        // 3
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toViewController.positionContainer(left: 0.0,
                                               right: 0.0,
                                               top: 0.0,
                                               bottom: 0.0)
        })
    }
}
