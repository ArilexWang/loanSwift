//
//  CreditCardOwnerMsgTableViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class CreditCardOwnerMsgTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var creditCardOwnerTF: UITextField!
    
    @IBOutlet weak var creditCardOwnerIDTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = userMesaage!["bank_card_owner_id_num"] {
            creditCardOwnerIDTF.text = str as? String
        }
        if let str = userMesaage!["bank_card_owner_name"] {
            creditCardOwnerTF.text = str as? String
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
