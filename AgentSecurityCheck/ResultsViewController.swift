//
//  ResultsViewController.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/3/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var topTachometer: SFGaugeView!
    var percentageValue: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Results"
        
        self.topTachometer.backgroundColor = UIColor.white
        self.topTachometer.bgColor = UIColor(red: CGFloat(249 / 255.0), green: CGFloat(203 / 255.0), blue: CGFloat(0 / 255.0), alpha: CGFloat(1))
        self.topTachometer.needleColor = UIColor(red: CGFloat(247 / 255.0), green: CGFloat(164 / 255.0), blue: CGFloat(2 / 255.0), alpha: CGFloat(1))
        self.topTachometer.isHideLevel = true
        self.topTachometer.minImage = "bad"
        self.topTachometer.maxImage = "good"
        
        self.topTachometer.isAutoAdjustImageColors = true
        self.topTachometer.currentLevel = 3 //percentageValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*
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
        let transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 180) * self.angle)
        self.needleImageView.transform = transform
        self.view.layoutIfNeeded()
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
*/
