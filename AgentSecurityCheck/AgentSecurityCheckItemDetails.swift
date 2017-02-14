//
//  AgentSecurityCheckItemDetails.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/13/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation

class AgentSecurityCheckItemDetails: NSObject {
    var title: String!
    var question: String!
    var choices:[AgentSecurityCheckItemDetailsChoices]!
    
    init(title: String, question: String, choices: [AgentSecurityCheckItemDetailsChoices]!) {
        self.title = title
        self.question = question
        self.choices = choices
    }
    
}
