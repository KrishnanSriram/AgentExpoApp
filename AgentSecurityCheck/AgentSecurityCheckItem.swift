//
//  AgentSecurityCheckItem.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/13/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation

class AgentSecurityCheckItem: NSObject {
    var title: String!
    var id: String!
    var details: AgentSecurityCheckItemDetails!
    
    init(id: String, title: String, details: AgentSecurityCheckItemDetails!) {
        self.id = id
        self.title = title
        self.details = details
    }
}
