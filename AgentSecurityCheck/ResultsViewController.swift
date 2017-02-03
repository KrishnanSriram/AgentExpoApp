//
//  ResultsViewController.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/3/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var needleImageView: UIImageView!
    private var angle: CGFloat!
    private var anchorPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Results"
        
        // min value
        self.angle = -118.4
        // max value
//        self.angle = 119
//        self.needleImageView.layer.anchorPoint = CGPoint(x: self.needleImageView.layer.anchorPoint.x, y: self.needleImageView.layer.anchorPoint.y*2)
        self.anchorPoint = self.needleImageView.layer.anchorPoint
//        self.setAnchorPoint(anchorPoint: anchorPoint, view: self.needleImageView)
        self.showResults(value: self.angle)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.angle = 56.0
        self.showResults(value: self.angle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showResults(value: CGFloat) {
        //UIView.animate(withDuration: 3) {
            let transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 180) * self.angle)
//            self.setAnchorPoint(anchorPoint: self.anchorPoint, view: self.needleImageView)
            self.needleImageView.transform = transform
            self.view.layoutIfNeeded()
//        }
    }
    
    func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
        var newPoint = CGPoint(x:view.bounds.size.width * anchorPoint.x, y:view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x:view.bounds.size.width * view.layer.anchorPoint.x, y:view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position : CGPoint = view.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x;
        
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.position = position;
        view.layer.anchorPoint = anchorPoint;
    }
    

}
