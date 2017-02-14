//
//  AgentSecurityDataManager.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/13/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import Foundation
class AgentSecurityDataManager: NSObject {
    func loadDataFromJSON() -> [AgentSecurityCheckItem]? {
        let file = "AgentSecurityCheck"
        let path = Bundle.main.path(forResource: file, ofType: "json")
        let pathURL = NSURL(fileURLWithPath: path!)
        var agentSecurityCheckItems: [AgentSecurityCheckItem]! = []
        
        if let jsonData = NSData(contentsOf: pathURL as URL) {
            if let dataDictionary = self.JSONToDictionary(data: jsonData) {
                if let securityCheckItems: NSArray = dataDictionary.object(forKey: "securityCheck") as? NSArray {
                    for index in 0..<securityCheckItems.count {
                        debugPrint("securityCheckItems: \(index)")
                        if let checkItem = self.extractSecurityCheckItem(securityCheckItem: securityCheckItems[index] as? NSDictionary) {
                            agentSecurityCheckItems.append(checkItem)
                        }
                    }
                }
            }
        }
        return agentSecurityCheckItems
    }
    
    private func JSONToDictionary(data: NSData) -> NSDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data,
                                                    options: .mutableContainers) as? NSDictionary
        } catch let jsonError {
            print(jsonError)
        }
        return nil
    }
    
    private func extractSecurityCheckItem(securityCheckItem: NSDictionary?) -> AgentSecurityCheckItem? {
        if let item = securityCheckItem {
            let title = item.object(forKey: "title") as! String
            let id = item.object(forKey: "id") as! String
            if let checkItemDetails = self.extractSecurityCheckItemDetails(securityCheckItemDetails: item.object(forKey: "details") as? NSDictionary) {
                return AgentSecurityCheckItem(id: id, title: title, details: checkItemDetails)
            }
        }
        
        return nil
    }
    
    private func extractSecurityCheckItemDetails(securityCheckItemDetails: NSDictionary?) -> AgentSecurityCheckItemDetails? {
        var checkItemDetails:[AgentSecurityCheckItemDetailsChoices]! = []
        if let details = securityCheckItemDetails {
            let question = details.object(forKey: "question") as! String
            let title = details.object(forKey: "title") as! String
            if let choices: NSArray = details.object(forKey: "choices") as? NSArray {
                for index in 0..<choices.count {
                    debugPrint("securityCheckItemDetails: \(index)")
                    if let choiceInfo = extractChoiceInfo(choice: choices[index] as? NSDictionary) {
                        checkItemDetails.append(choiceInfo)
                    }
                }
            }
            return AgentSecurityCheckItemDetails(title: title, question: question, choices: checkItemDetails)
        }
        
        return nil
    }
    
    private func extractChoiceInfo(choice: NSDictionary?) -> AgentSecurityCheckItemDetailsChoices? {
        if let choiceItem = choice {
            let choice = choiceItem.object(forKey: "choice") as! String
            let choice_id = choiceItem.object(forKey: "id") as! String
            return AgentSecurityCheckItemDetailsChoices(id: choice_id, choice: choice)
        }
        
        return nil
    }
    
}
