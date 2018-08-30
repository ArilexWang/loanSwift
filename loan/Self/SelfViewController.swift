//
//  SelfViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/29.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfViewController: UIViewController,GetSignalDelegate {
    
    @IBOutlet weak var lockImg: UIImageView!
    
    @IBOutlet weak var selfMsgContainView: UIView!
    
    @IBOutlet weak var otherMsgContainView: UIView!
    
    var selfMsgTVC: SelfMsgTableViewController?
    var otherMsgTVC: OtherMsgTableViewController?
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        lockImg.isUserInteractionEnabled = true
        lockImg.addGestureRecognizer(tapGestureRecognizer)
        
        
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        performSegue(withIdentifier: "segueToLogin", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = ""
        switch segue.identifier {
        case "segueToSelfMsg":
            let destinationVC = segue.destination as? SelfMsgTableViewController
            self.selfMsgTVC = destinationVC
            destinationVC?.delegate = self
        case "segueToOtherMsg":
            let des = segue.destination as? OtherMsgTableViewController
            des?.delegate = self
            self.otherMsgTVC = des
         default:
            break
        }
    }
    
    func getSignal(controller: OtherMsgTableViewController, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "segueToResetPassword", sender: nil)
        default:
            break
        }
    }
    
    func getSignalFromSelfTVC(controller: SelfMsgTableViewController, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "segueToSelfMsgVC", sender: nil)
        case 1:
            performSegue(withIdentifier: "segueToLoanListTVC", sender: nil)
        default:
            break
        }
    }
    

}
