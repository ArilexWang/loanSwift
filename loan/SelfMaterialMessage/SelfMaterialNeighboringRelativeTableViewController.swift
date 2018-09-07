//
//  SelfMaterialNeighboringRelativeTableViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfMaterialNeighboringRelativeTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var relationshipTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let str = userMesaage!["oc_name"] {
            nameTF.text = str as? String
        }
        if let str = userMesaage!["oc_phone"] {
            phoneNumberTF.text = str as? String
        }
        if let str = userMesaage!["oc_relationship"] {
            relationshipTF.text = str as? String
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
