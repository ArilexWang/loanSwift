//
//  CreditCardMsgTableViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CreditCardMsgTableViewController: UITableViewController,UITextFieldDelegate {

    let banks = ["工商银行", "建设银行", "中国银行","农业银行","交通银行","招商银行","中信银行","光大银行","华夏银行","浦发银行",
                "兴业银行","民生银行","平安银行","广发银行","恒丰银行","渤海银行","浙商银行"]

    var selectBank: String = "工商银行"
    
    @IBOutlet weak var bankBtn: UIButton!
    
    @IBAction func bankBtnClick(_ sender: UIButton) {
        
        ActionSheetStringPicker.show(withTitle: "请选择银行", rows: banks, initialSelection: 0, doneBlock: {
            picker, value, index in
            
            self.selectBank = index as! String
            self.bankBtn.titleLabel?.text = self.selectBank;
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
    }
    
    @IBOutlet weak var creditCardIDTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let str = userMesaage!["bank_card_num"] {
            creditCardIDTF.text = str as? String
        }
        if let str = userMesaage!["bank_account"] {
            selectBank = (str as? String)!
            bankBtn.setTitle(selectBank, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
