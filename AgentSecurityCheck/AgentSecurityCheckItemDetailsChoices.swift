//
//  AgentSecurityCheckItemDetailsChoices.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/13/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation

class AgentSecurityCheckItemDetailsChoices: NSObject {
    var choiceId: String!
    var choice: String!
    
    init(id: String, choice: String) {
        self.choiceId = id
        self.choice = choice
    }
}
