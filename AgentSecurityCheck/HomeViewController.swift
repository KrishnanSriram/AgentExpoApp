//
//  HomeViewControllerCollectionViewController.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/2/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

private let reuseIdentifier = "QuestionaireTitleCell"

enum QuestionaireType: Int {
    case wireless
    case securityplan
    case antivirus
    case accountaudits
    case networkmonitor
    case removablemedia
    case passwords
    case mobilesecurity
    case securitytraining
}

protocol ChoiceTableViewControllerDelegate {
    func selectedChoice(choice: AgentSecurityCheckItemDetailsChoices)
}

class HomeViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    var securityCheckItems: [AgentSecurityCheckItem] = []
    var securityResonse: AgentSecurityResponse!
    private let customPresentAnimationController = CustomPresentAnimationController()
    private let customNavigationAnimationController = CustomNavigationAnimationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(image: UIImage(named: "submit"), style: .plain, target: self, action: #selector(submitButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        

        self.collectionView!.register(UINib(nibName:"QuestionaireTypeCVCellCollectionViewCell",
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "QuestionaireTitleCell")
        
        if let checkItems = AppManager.sharedInstance.loadAgentSecurityCheckItems() {
            self.securityCheckItems = checkItems
        }
        
        self.title = "Check your technology score."
        
        securityResonse = AgentSecurityResponse()
        
//        self.setupGradientBGView()
        self.setupBGImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetResponse),
                                               name: NSNotification.Name(rawValue: "ResetQuizNotification"),
                                               object: nil)
        navigationController?.delegate = self

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customNavigationAnimationController.reverse = operation == .pop
        return customNavigationAnimationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.securityCheckItems.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 297, height: 209);
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuestionaireTypeCVCellCollectionViewCell
    
        self.imageForCell(indexPath: indexPath, cell: cell)
        self.labelTextForCell(indexPath: indexPath, cell: cell)
        let label: UILabel = cell.viewWithTag(30) as! UILabel
        label.isHidden = true
        
        cell.contentView.backgroundColor = indexPath.row == 0 ? UIColor.black : UIColor.white
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.yellow.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.red.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 10.0
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let popController = storyboard.instantiateViewController(withIdentifier: "ChoicesTableViewController") as! ChoicesTableViewController
            //ChoicesTableViewController(style: .grouped)
        popController.transitioningDelegate = self
        popController.viewData = self.securityCheckItems[indexPath.row].details
        popController.questionId = self.securityCheckItems[indexPath.row].id
        popController.choiceDelegate = self
        presentChoicesAsFormController(viewController: popController, selectedItem: indexPath)
//        presentChoicesAsPopOver(viewController: popController)
        
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.checkToReset()
        }
    }
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return customPresentAnimationController
//    }
    
    
    private func checkToReset() {
        let alertController = UIAlertController(title: "Start over again?", message: "Do you want to restart quiz?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.resetResponse()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Force popover style
        return UIModalPresentationStyle.none
    }
    
    func presentChoicesAsFormController(viewController formController: UIViewController, selectedItem: IndexPath) {
        let navController = UINavigationController(rootViewController: formController)
        navController.modalPresentationStyle = .formSheet
        navController.transitioningDelegate = self
        navController.modalTransitionStyle = .crossDissolve
        self.present(navController, animated: true, completion: nil)
    }
    
    func presentChoicesAsPopOver(viewController popController: UIViewController) {
        let navController = UINavigationController(rootViewController: popController)
        
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = .unknown
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = self.view // button
        let rect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        popController.popoverPresentationController?.sourceRect = rect
        
        // present the popover
        self.present(navController, animated: true, completion: nil)
    }
    
    func imageForCell(indexPath: IndexPath, cell: UICollectionViewCell) {
        let imageView: UIImageView = cell.viewWithTag(20) as! UIImageView
        switch indexPath.row {
        case 0:
            imageView.image = UIImage(named: "Q1")
        case 1:
            imageView.image = UIImage(named: "Q2")
        case 2:
            imageView.image = UIImage(named: "Q3")
        case 3:
            imageView.image = UIImage(named: "Q4")
        case 4:
            imageView.image = UIImage(named: "Q5")
        case 5:
            imageView.image = UIImage(named: "Q6")
        case 6:
            imageView.image = UIImage(named: "Q7")
        case 7:
            imageView.image = UIImage(named: "Q8")
        case 8:
            imageView.image = UIImage(named: "Q9")
        default:
            imageView.image = UIImage(named: "Q1")
        }
    }
    
    func labelTextForCell(indexPath: IndexPath, cell: QuestionaireTypeCVCellCollectionViewCell) {
        let label: UILabel = cell.headingLabel
        label.text = self.securityCheckItems[indexPath.row].title
        label.font = UIFont(name: "Futura", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
    
    func resultsTextForCell(indexPath: IndexPath, cell: UICollectionViewCell) {
        let label: UILabel = cell.viewWithTag(30) as! UILabel
        switch indexPath.row {
        case 0:
            label.text = ""
        case 1:
            label.text = ""
        case 2:
            label.text = ""
        case 3:
            label.text = ""
        case 4:
            label.text = ""
        case 5:
            label.text = ""
        case 6:
            label.text = ""
        case 7:
            label.text = ""
        case 8:
            label.text = ""
        default:
            label.text = ""
        }
        
        label.isHidden = true
    }
    
    func submitButtonPressed(sender: UIButton) {
        if self.canSubmit() == true {
            let percentage = self.calculateScoreFromSelectedChoices(selectedChoice: self.securityResonse)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let resultsController = storyboard.instantiateViewController(withIdentifier: "result") as! ResultsViewController
            resultsController.percentageValue = percentage
            resultsController.score = self.textScoreFrom(percentage: percentage)
            self.navigationController?.pushViewController(resultsController, animated: true)
        } else {
            let controller = UIAlertController(title: "Submit Response", message: "Please answer all questions to submit your response", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func canSubmit() -> Bool {
        return self.securityCheckItems.count == self.securityResonse.choices.count
    }
    
    private func textScoreFrom(percentage: Int) -> String {
        var text = "Low"
        if percentage > 3 && percentage <= 7 {
            text = "Medium"
        } else if percentage > 7 {
            text = "High"
        }
        
        return text
    }
    
    private func calculateScoreFromSelectedChoices(selectedChoice: AgentSecurityResponse) -> Int {
        var totalWeight = 0
        var percentage = 0
        
        for choice: AgentSecurityCheckItemDetailsChoices in selectedChoice.choices {
            let weight = Int(choice.weight)
            totalWeight = totalWeight + weight!
        }
        if totalWeight > 0 {
            percentage = (totalWeight*10)/(selectedChoice.choices.count * 100)
        }
        
        return percentage
    }
    
    func setupBGImage() {
        let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        collectionView!.backgroundView = imageView
    }
    
    func setupGradientBGView() {
        let collectionGradient = CAGradientLayer()
        collectionGradient.bounds = self.view.bounds
        collectionGradient.anchorPoint = CGPoint.zero
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        collectionGradient.colors = [colorTop, colorBottom]
        let vv = UIView()
        self.collectionView!.backgroundView = vv
        self.collectionView!.backgroundView!.layer.insertSublayer(collectionGradient, at: 0)
    }
    
    func resetResponse() {
        self.securityResonse = AgentSecurityResponse()
        self.collectionView?.reloadData()
    }

}

extension HomeViewController: ChoiceTableViewControllerDelegate {
    func selectedChoice(choice: AgentSecurityCheckItemDetailsChoices) {
        self.securityResonse.addResponse(newChoice: choice)
        
        let selectedItem = self.collectionView?.indexPathsForSelectedItems?.first
        let cell: QuestionaireTypeCVCellCollectionViewCell = self.collectionView?.cellForItem(at: selectedItem!) as! QuestionaireTypeCVCellCollectionViewCell
        cell.statusLabel.text = "Answered"
        cell.statusLabel.textColor = UIColor.blue
        cell.statusLabel.isHidden = false
    }
    
    
}
