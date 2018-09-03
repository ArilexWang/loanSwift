//
//  SignUpViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/23.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    var signupTVC: SignUpTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func submitBtnClick(_ sender: UIButton) {
        let code = signupTVC?.codeTF.text
        let tele = "17717231435"
        
        //发送验证码
        SMSSDK.commitVerificationCode(code, phoneNumber: tele, zone: "86") { (error) in
            //验证成功
            if (error.debugDescription == "nil"){
                
            } else {  //失败
                let alertController = UIAlertController(title: nil,
                                                        message: "验证码输入错误", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedSignupTVC":
            self.signupTVC = segue.destination as? SignUpTableViewController
        default:
            break
        }
    }

}
