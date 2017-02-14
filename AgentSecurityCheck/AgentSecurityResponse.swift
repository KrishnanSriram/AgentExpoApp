//
//  AgentSecurityResponse.swift
//  AgentSecurityCheck
//
//  Created by Sriram, Krishnan on 2/14/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation

class AgentSecurityResponse: NSObject {
    // AgentSecurityCheckItemDetailsChoices.id is the ID of the question
    // AgentSecurityCheckItemDetailsChoices.choice is the selected answer/choice
    var choices:[AgentSecurityCheckItemDetailsChoices]!
    
    override init() {
        self.choices = []
    }
    
    func addResponse(newChoice: AgentSecurityCheckItemDetailsChoices) {
        for choice:AgentSecurityCheckItemDetailsChoices in choices {
            if choice.choiceId.lowercased() == newChoice.choiceId.lowercased() {
                choice.choice = newChoice.choice
            }
        }
    }
    
    func clearAllChoices() {
        self.choices = []
    }

}
