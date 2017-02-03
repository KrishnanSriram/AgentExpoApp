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
    var viewData: NSDictionary!
    var previousSelectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(dismissView(sender:)))
        
        let rightBarButton1 = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(dismissView(sender:)))
        let rightBarButton2 = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showHelpText(sender:)))

        self.navigationItem.rightBarButtonItems = [rightBarButton1, rightBarButton2]
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.dataManager = ChoicesDataManager()
        self.viewData = self.dataManager.dataForChoice(choiceType: self.viewDataType)
        
        self.title = self.viewData.object(forKey: "title") as? String
            //self.titleForView(viewType: self.viewDataType)
        self.formatNavigationBar(navigationBar: (self.navigationController?.navigationBar)!)
        
        self.view.backgroundColor = UIColor.white
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewData.object(forKey: "question") as? String
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let choicesArray: NSArray = self.viewData.object(forKey: "choices") as! NSArray
        return choicesArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
        
        let choicesArray: NSArray = self.viewData.object(forKey: "choices") as! NSArray
        
        let choice = choicesArray.object(at: indexPath.row) as! NSDictionary
        cell.backgroundColor = UIColor.clear
        
        let cellBackgroundView = cell.viewWithTag(10)! as UIView
        cellBackgroundView.backgroundColor = UIColor.white
            //UIColor(red: 153/255, green: 255/255, blue: 153/255, alpha: 1)
        cellBackgroundView.layer.cornerRadius = 4
        cellBackgroundView.layer.masksToBounds = false
        cellBackgroundView.layer.shadowColor = UIColor.black.cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cellBackgroundView.layer.shadowOpacity = 0.8
        
        let contentid_label = cell.viewWithTag(20) as! UILabel
        contentid_label.text = choice.object(forKey: "choice_id") as? String
        
        let content_text_label = cell.viewWithTag(30) as! UILabel
        content_text_label.text = choice.object(forKey: "choice") as? String
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
            cellBackgroundView.backgroundColor = UIColor.white
            
            let contentid_label = cell.viewWithTag(20) as! UILabel
            contentid_label.textColor = UIColor.black
            
            let content_text_label = cell.viewWithTag(30) as! UILabel
            content_text_label.textColor = UIColor.black
        }
        
        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        let cellBackgroundView = cell.viewWithTag(10)! as UIView
        cellBackgroundView.backgroundColor = UIColor.black
        
        let contentid_label = cell.viewWithTag(20) as! UILabel
        contentid_label.textColor = UIColor.white
        
        let content_text_label = cell.viewWithTag(30) as! UILabel
        content_text_label.textColor = UIColor.white
        
        self.previousSelectedIndex = indexPath
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func formatNavigationBar(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = UIColor.white
//            ColorManager.sharedInstance.questionsNavigationBarBGColor()
        navigationBar.shadowImage = UIImage()
    }
    
    func titleForView(viewType: QuestionaireType) -> String {
        var viewTitle: String = ""
        /*
         Move all of this data out to service layer
        */
        switch viewType.rawValue {
        case 0:
            viewTitle = "QUESTION ONE"
        case 1:
            viewTitle = "QUESTION TWO"
        case 2:
            viewTitle = "QUESTION THREE"
        case 3:
            viewTitle = "QUESTION FOUR"
        case 4:
            viewTitle = "QUESTION FIVE"
        case 5:
            viewTitle = "QUESTION SIX"
        case 6:
            viewTitle = "QUESTION SEVEN"
        case 7:
            viewTitle = "QUESTION EIGHT"
        case 8:
            viewTitle = "QUESTION NINE"
        default:
            viewTitle = ""
        }
        
        return viewTitle
    }
    
    func dismissView(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showHelpText(sender: UIBarButtonItem) {
        debugPrint("Show help")
    }

}
