//
//  LoanConfirmViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Alamofire


class LoanConfirmViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var loanNumLbl: UILabel!
    
    @IBOutlet weak var loanMonthLbl: UILabel!
    
    @IBOutlet weak var paybackLbl: UILabel!
    
    @IBOutlet weak var interestLbl: UILabel!
    
    @IBOutlet weak var actualMoney: UILabel!
    
    var loanMsg: LoanMsg? {
        didSet{
            
            DispatchQueue.main.async {
                self.loanNumLbl?.text = String(format: "%d", (self.loanMsg?.loanNum)!)
                self.loanMonthLbl?.text = String(format: "%d", (self.loanMsg?.loanMonth)!)
                self.paybackLbl?.text = String(format: "%d", (self.loanMsg?.payback)!)
                self.interestLbl?.text = String(format: "%d", (self.loanMsg?.interest)!)
                self.actualMoney?.text = String(format: "%d", (self.loanMsg?.actualMoney)!)
            }
        }
    }
    @IBOutlet weak var referrerIDTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func submitBtnClick(_ sender: UIButton) {
        let para = [
            "borrower_id": userMesaage!["id"],
            "referrer_id": referrerIDTF.text,
            "amount": self.loanMsg?.loanNum,
            "period": self.loanMsg?.loanMonth
        ]
        
        Alamofire.request(ApplyNewLoanURL, method: .post, parameters: para, encoding: JSONEncoding.default).responseJSON { (response) in
            if(response.result.isSuccess) {
                let dic = response.result.value as? [String: AnyObject]
                if (dic!["result"] as! String != "success"){
                    let alertController = UIAlertController(title: nil,
                                                            message: dic!["result"] as! String, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: nil,
                                                            message: "已申请成功，请耐心等待审核", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                        action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                
                print(response.debugDescription)
            }
        }
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
