//
//  ColorManager.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/3/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation
import UIKit

class ColorManager: NSObject {
    static let sharedInstance : ColorManager = {
        let instance = ColorManager()
        return instance
    }()
    
    func questionsViewBGColor() -> UIColor {
//        return UIColor(red: 146/255, green: 208/255, blue: 80/255, alpha: 1.0)
        return UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
    }
    
    func questionsNavigationBarBGColor() -> UIColor {
//        return UIColor(red: 146/255, green: 208/255, blue: 80/255, alpha: 1.0)
        return UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
    }
}
