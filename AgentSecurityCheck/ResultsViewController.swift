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
    var actionToEnable: UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Results"
        
        self.topTachometer.backgroundColor = UIColor.white
        self.topTachometer.bgColor = UIColor(red: CGFloat(249 / 255.0), green: CGFloat(203 / 255.0), blue: CGFloat(0 / 255.0), alpha: CGFloat(1))
        self.topTachometer.needleColor = UIColor(red: CGFloat(247 / 255.0), green: CGFloat(164 / 255.0), blue: CGFloat(2 / 255.0), alpha: CGFloat(1))
        self.topTachometer.isHideLevel = true
//        self.topTachometer.minImage = "bad"
//        self.topTachometer.maxImage = "good"
        
        self.topTachometer.isAutoAdjustImageColors = true
        self.topTachometer.currentLevel = percentageValue

        let rightBarButton = UIBarButtonItem(title: "Reset",
                                             style: .plain,
                                             target: self,
                                             action: #selector(resetButtonTapped(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func subscribeButtonTapped(sender: UIButton) {
        let alertController = UIAlertController(title: "Email ID for subscription",
                                                message: "Please enter your email ID", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Notify", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            debugPrint(firstTextField.text)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter your Email ID"
            textField.keyboardType = .emailAddress
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.actionToEnable = saveAction
        saveAction.isEnabled = false
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    func validateTextFieldForEMail(text: String?) -> Bool {
        var retFlag = false
        if let _ = text {
          retFlag = self.isValidEmail(emailStr: text!)
        }
        
        return retFlag
    }
    
    func textChanged(_ sender:UITextField) {
        self.actionToEnable?.isEnabled  = self.validateTextFieldForEMail(text: sender.text)
    }
    
    func resetButtonTapped(sender: UIBarButtonItem) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "ResetQuizNotification")))
        _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
