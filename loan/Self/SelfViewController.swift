//
//  SelfViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/29.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfViewController: UIViewController {

    

    @IBOutlet weak var lockImg: UIImageView!
    
    @IBOutlet weak var selfMsgContainView: UIView!
    
    @IBOutlet weak var otherMsgContainView: UIView!
    
    var selfMsgTVC: SelfMsgTableViewController?
    var otherMsgTVC: OtherMsgTableViewController?
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        
        switch segue.identifier {
        case "segueToLogin":
            navigationItem.title = ""
        case "segueToSelfMsg":
            self.selfMsgTVC = segue.destination as? SelfMsgTableViewController
        case "segueToOtherMsg":
            self.otherMsgTVC = segue.destination as? OtherMsgTableViewController
        default:
            break
        }
        
        
    }

}
