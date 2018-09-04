//
//  LoginByPasswordTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/23.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class LoginByPasswordTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var accountTextField: UITextField!{
        didSet{
            accountTextField.delegate = self
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
