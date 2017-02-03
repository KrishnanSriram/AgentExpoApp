//
//  HomeViewControllerCollectionViewController.swift
//  AgentSecurityCheck
//
//  Created by Krishnan Sriram Rama on 2/2/17.
//  Copyright © 2017 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SecurityCell"

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

class HomeViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(image: UIImage(named: "submit"), style: .plain, target: self, action: #selector(submitButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
//        self.imageForCell(indexPath: indexPath, cell: cell)
        self.labelTextForCell(indexPath: indexPath, cell: cell)
        
        cell.contentView.backgroundColor = UIColor.white
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
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
        popController.viewDataType = QuestionaireType(rawValue: indexPath.row)
        presentChoicesAsFormController(viewController: popController, selectedItem: indexPath)
        
        
    }
    
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Force popover style
        return UIModalPresentationStyle.none
    }
    
    func presentChoicesAsFormController(viewController formController: UIViewController, selectedItem: IndexPath) {
        let navController = UINavigationController(rootViewController: formController)
        navController.modalPresentationStyle = .formSheet
        self.present(navController, animated: true, completion: nil)
    }
    
    func presentChoicesAsPopOver(viewController popController: UIViewController) {
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.unknown
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = self.view // button
        let rect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        popController.popoverPresentationController?.sourceRect = rect
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
    
    func imageForCell(indexPath: IndexPath, cell: UICollectionViewCell) {
        let imageView: UIImageView = cell.viewWithTag(20) as! UIImageView
        switch indexPath.row {
        case 0:
            imageView.image = UIImage(named: "wifi")
        case 1:
            imageView.image = UIImage(named: "plan")
        case 2:
            imageView.image = UIImage(named: "antivirus")
        case 3:
            imageView.image = UIImage(named: "search")
        case 4:
            imageView.image = UIImage(named: "wifi")
        case 5:
            imageView.image = UIImage(named: "wifi")
        case 6:
            imageView.image = UIImage(named: "wifi")
        case 7:
            imageView.image = UIImage(named: "wifi")
        case 8:
            imageView.image = UIImage(named: "wifi")
        default:
            imageView.image = UIImage(named: "wifi")
        }
    }
    
    func labelTextForCell(indexPath: IndexPath, cell: UICollectionViewCell) {
        let label: UILabel = cell.viewWithTag(10) as! UILabel
        switch indexPath.row {
        case 0:
            label.text = "Wireless Security"
        case 1:
            label.text = "Security plan & policies"
        case 2:
            label.text = "Anti-Virus Software"
        case 3:
            label.text = "Accounts and Passwords audit"
        case 4:
            label.text = "Traffic monitor"
        case 5:
            label.text = "Storage media policies"
        case 6:
            label.text = "Password policies"
        case 7:
            label.text = "Mobile device security"
        case 8:
            label.text = "Security trainning"
        default:
            label.text = "Wireless Security"
        }
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
        self.performSegue(withIdentifier: "result", sender: self)
    }

}
