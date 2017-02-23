//
//  CustomPresentationAnimationController.swift
//  AgentSecurityCheck
//
//  Created by Sriram, Krishnan on 2/22/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation
import UIKit

class CustomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
//        var frame = transitionContext.finalFrame(for: toViewController)
//        frame.origin.x = UIScreen.main.bounds.midX
//        frame.origin.y = UIScreen.main.bounds.midY
//        let finalFrameForVC = frame
//            //transitionContext.finalFrame(for: toViewController)
//        let containerView = transitionContext.containerView
//        let bounds = UIScreen.main.bounds
//        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
//        containerView.addSubview(toViewController.view)
//        
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
//            fromViewController.view.alpha = 0.5
//            toViewController.view.frame = finalFrameForVC
//        }, completion: {
//            finished in
//            transitionContext.completeTransition(true)
//            fromViewController.view.alpha = 1.0
//        })
//    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0.5
        containerView.addSubview(toViewController.view)
        containerView.sendSubview(toBack: toViewController.view)
        
        let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = fromViewController.view.frame
        containerView.addSubview(snapshotView!)
        
        fromViewController.view.removeFromSuperview()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            snapshotView?.frame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2)
            toViewController.view.alpha = 1.0
        }, completion: {
            finished in
            snapshotView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        })  
    }
}
