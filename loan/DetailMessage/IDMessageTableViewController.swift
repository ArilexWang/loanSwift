//
//  IDMessageTableViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class IDMessageTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var idNumTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let str = userMesaage!["user_name"] {
            nameTF.text = str as? String
        }
        
        if let str = userMesaage!["id_card_num"] {
            idNumTF.text = str as? String
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
