//
//  ChoicesDataManager.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/3/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class ChoicesDataManager: NSObject {
    private let PLIST_FILE_NAME:String = "ChoicesData"
    private var choicesData: NSDictionary!
    
    override init() {
        super.init()
        self.readPlistFileForData(plistFile: PLIST_FILE_NAME)
    }
    
    private func readPlistFileForData(plistFile: String) {
        let path = Bundle.main.path(forResource: self.PLIST_FILE_NAME, ofType: "plist")
        self.choicesData = NSDictionary(contentsOfFile: path!)
    }
    
    func dataForChoice(choiceType:QuestionaireType) -> NSDictionary {
        var data: NSDictionary!
        
        switch choiceType {
        case .accountaudits:
            debugPrint("fetch accountaudits data - 4")
            data = self.choicesData.object(forKey: "4") as! NSDictionary
        case .antivirus:
            debugPrint("fetch antivirus data - 3")
            data = self.choicesData.object(forKey: "3") as! NSDictionary
        case .mobilesecurity:
            debugPrint("fetch mobilesecurity data - 8")
            data = self.choicesData.object(forKey: "8") as! NSDictionary
        case .networkmonitor:
            debugPrint("fetch networkmonitor data - 5")
            data = self.choicesData.object(forKey: "5") as! NSDictionary
        case .passwords:
            debugPrint("fetch passwords data - 7")
            data = self.choicesData.object(forKey: "7") as! NSDictionary
        case .removablemedia:
            debugPrint("fetch removablemedia data - 6")
            data = self.choicesData.object(forKey: "6") as! NSDictionary
        case .securityplan:
            debugPrint("fetch securityplan data - 2")
            data = self.choicesData.object(forKey: "2") as! NSDictionary
        case .securitytraining:
            debugPrint("fetch securitytraining data - 9")
            data = self.choicesData.object(forKey: "9") as! NSDictionary
        case .wireless:
            debugPrint("fetch wireless data - 1")
            data = self.choicesData.object(forKey: "1") as! NSDictionary
        }
        
        return data
    }
}
