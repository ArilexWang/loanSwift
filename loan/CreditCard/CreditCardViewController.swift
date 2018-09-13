//
//  CreditCardViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Alamofire

class CreditCardViewController: UIViewController {

    var bankTVC: CreditCardMsgTableViewController?
    
    var ownerMsgTVC: CreditCardOwnerMsgTableViewController?
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        
        userMesaage!["bank_card_owner_name"] = self.ownerMsgTVC?.creditCardOwnerTF.text
        userMesaage!["bank_card_owner_id_num"] = self.ownerMsgTVC?.creditCardOwnerIDTF.text
        
        userMesaage!["bank_card_num"] = self.bankTVC?.creditCardIDTF.text
        userMesaage!["bank_account"] = self.bankTVC?.selectBank
        
        Alamofire.request(UpdateUserInfoURL, method: .post, parameters: userMesaage, encoding: JSONEncoding.default).responseJSON { (response) in
            if(response.result.isSuccess) {
                let dic = response.result.value as? [String: AnyObject]
               
                if (dic!["result"] as! String != "success"){
                    let alertController = UIAlertController(title: nil,
                                                            message: dic!["result"] as! String, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    userMesaage = dic
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                print(response.debugDescription)
            }
        }
        
        
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
