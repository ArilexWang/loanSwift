//
//  SelfMessageViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfMessageViewController: UIViewController,SelfMessageVCGetSignalDelegate {
    
    var selfDetailMsgTVC: SelfDetailMessageTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = ""
        switch segue.identifier {
        case "segueToDetailMsgTVC":
            let des = segue.destination as! SelfDetailMessageTableViewController
            des.delegate = self
            self.selfDetailMsgTVC = des
        default:
            break
        }
    }
    
    func getSignalFromSelfDetailMsgTVC(controller: SelfDetailMessageTableViewController, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "segueToIDVC", sender: nil)
        case 1:
            performSegue(withIdentifier: "segueToCustomMessageVC", sender: nil)
        case 2:
            performSegue(withIdentifier: "segueToBankCardVC", sender: nil)
        default:
            break
        }
    }

}
