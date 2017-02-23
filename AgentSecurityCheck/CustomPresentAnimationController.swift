//
//  CustomPresentationAnimationController.swift
//  AgentSecurityCheck
//
//  Created by Sriram, Krishnan on 2/22/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation
import UIKit


class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        var finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        finalFrameForVC.size = CGSize(width: 500, height: 600)
        finalFrameForVC.origin = CGPoint(x: 150, y: 300)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        })
    }
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
//        let endFrame = CGRect(x: 80, y: 280, width: 160, height: 100)
//        
//        fromViewController.view.isUserInteractionEnabled = false
//        transitionContext.containerView.addSubview(fromViewController.view)
//        transitionContext.containerView.addSubview(toViewController.view)
//        var startFrame: CGRect = endFrame
//        startFrame.origin.y += 320
//        toViewController.view.frame = startFrame
//        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {() -> Void in
//            fromViewController.view.tintAdjustmentMode = .dimmed
//            toViewController.view.frame = endFrame
//        }, completion: {(_ finished: Bool) -> Void in
//            transitionContext.completeTransition(true)
//        })
//    }
}
