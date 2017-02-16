//
//  ChoicesTableViewController.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/3/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class ChoicesTableViewController: UITableViewController {

    var viewDataType: QuestionaireType!
    private var dataManager: ChoicesDataManager!
    var viewData: AgentSecurityCheckItemDetails!
    var questionId: String!
    var choiceDelegate: ChoiceTableViewControllerDelegate!
    var previousSelectedIndex: IndexPath?
    var rightBarButton1: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(dismissView(sender:)))
        
        rightBarButton1 = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveButtonTapped(sender:)))
        let rightBarButton2 = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showHelpText(sender:)))
        
        rightBarButton1.isEnabled = false;

        self.navigationItem.rightBarButtonItems = [rightBarButton1, rightBarButton2]
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.dataManager = ChoicesDataManager()
        
        self.title = viewData.title
            //self.titleForView(viewType: self.viewDataType)
        self.formatNavigationBar(navigationBar: (self.navigationController?.navigationBar)!)
        
        self.setupGradientBGView()
//        self.view.backgroundColor = UIColor.white
            //ColorManager.sharedInstance.questionsViewBGColor()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 16)
        header.textLabel?.textColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewData.question
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewData.choices.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
        
        let choice = self.viewData.choices[indexPath.row]
        cell.backgroundColor = UIColor.clear
        
        let cellBackgroundView = cell.viewWithTag(10)! as UIView
        cellBackgroundView.backgroundColor = UIColor.black
            //UIColor(red: 153/255, green: 255/255, blue: 153/255, alpha: 1)
        cellBackgroundView.layer.cornerRadius = 4
        cellBackgroundView.layer.masksToBounds = false
        cellBackgroundView.layer.shadowColor = UIColor.black.cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cellBackgroundView.layer.shadowOpacity = 0.8
        
        let contentid_label = cell.viewWithTag(20) as! UILabel
        contentid_label.text = choice.choiceId
        contentid_label.font = UIFont(name: "Futura", size: 16)
        contentid_label.textColor = UIColor.white
        
        let content_text_label = cell.viewWithTag(30) as! UILabel
        content_text_label.text = choice.choice
        content_text_label.font = UIFont(name: "Futura", size: 16)
        content_text_label.textColor = UIColor.white
        content_text_label.numberOfLines = 0
        content_text_label.lineBreakMode = .byWordWrapping
        content_text_label.textAlignment = .left
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = previousSelectedIndex {
            let cell = tableView.cellForRow(at: previousSelectedIndex!)! as UITableViewCell
            
            let cellBackgroundView = cell.viewWithTag(10)! as UIView
            cellBackgroundView.backgroundColor = UIColor.black
            
            let contentid_label = cell.viewWithTag(20) as! UILabel
            contentid_label.textColor = UIColor.white
            
            let content_text_label = cell.viewWithTag(30) as! UILabel
            content_text_label.textColor = UIColor.white
        }
        
        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        let cellBackgroundView = cell.viewWithTag(10)! as UIView
        cellBackgroundView.backgroundColor = UIColor.yellow
        
        let contentid_label = cell.viewWithTag(20) as! UILabel
        contentid_label.textColor = UIColor.red
        
        let content_text_label = cell.viewWithTag(30) as! UILabel
        content_text_label.textColor = UIColor.red
        
        self.previousSelectedIndex = indexPath
        
        self.rightBarButton1.isEnabled = true
    }
    
    func formatNavigationBar(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = UIColor.white
//            ColorManager.sharedInstance.questionsNavigationBarBGColor()
        navigationBar.shadowImage = UIImage()
    }
    
    func saveButtonTapped(sender: UIBarButtonItem) {
        let choice = self.viewData.choices[(self.tableView.indexPathForSelectedRow?.row)!]
        let checkItemDetails = AgentSecurityCheckItemDetailsChoices(id: self.questionId,
                                                                    choice: choice.choiceId,
                                                                    weight: choice.weight)
        self.choiceDelegate.selectedChoice(choice: checkItemDetails)
        self.dismissView(sender: sender)
    }
    
    func dismissView(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showHelpText(sender: UIBarButtonItem) {
        debugPrint("Show help")
    }
    
    func setupGradientBGView() {
        let collectionGradient = CAGradientLayer()
        collectionGradient.bounds = self.view.bounds
        collectionGradient.anchorPoint = CGPoint.zero
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        collectionGradient.colors = [colorTop, colorBottom]
        let vv = UIView()
        self.tableView!.backgroundView = vv
        self.tableView!.backgroundView!.layer.insertSublayer(collectionGradient, at: 0)
    }

}
