//
//  SelfMaterialImmediateFamilyTableViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfMaterialImmediateFamilyTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var relationshipTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    


}
