//
//  AppManager.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/3/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation

class AppManager: NSObject {
    
    static let sharedInstance : AppManager = {
        let instance = AppManager()
        return instance
    }()
    
    func loadAgentSecurityCheckItems() -> [AgentSecurityCheckItem]? {
        let agentSecurityManager = AgentSecurityDataManager()
        return agentSecurityManager.loadDataFromJSON()
    }
}
