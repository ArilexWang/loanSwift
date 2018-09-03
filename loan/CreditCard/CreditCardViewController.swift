//
//  CreditCardViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {

    var bankTVC: CreditCardMsgTableViewController?
    
    var ownerMsgTVC: CreditCardOwnerMsgTableViewController?
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        
        print(bankTVC?.selectBank)
        print(bankTVC?.creditCardIDTF.text)
        print(ownerMsgTVC?.creditCardOwnerTF.text)
        print(ownerMsgTVC?.creditCardOwnerIDTF.text)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedBankTVC":
            self.bankTVC = segue.destination as? CreditCardMsgTableViewController
        case "embedOwnerMsgTVC":
            self.ownerMsgTVC = segue.destination as? CreditCardOwnerMsgTableViewController
        default:
            break
        }
    }



}
