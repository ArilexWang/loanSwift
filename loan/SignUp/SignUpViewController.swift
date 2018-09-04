//
//  SignUpViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/23.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    
    var signupTVC: SignUpTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func submitBtnClick(_ sender: UIButton) {
        let code = signupTVC?.codeTF.text
        let tele = signupTVC?.phoneNumberTF.text
        let referrer_id = signupTVC?.referrerIDTF.text
        let password = signupTVC?.passwordTF.text
        let verify_code = "0"
        
        //发送验证码
        SMSSDK.commitVerificationCode(code, phoneNumber: tele, zone: "86") { (error) in
            //验证成功
            if (error.debugDescription == "nil"){
                let para:Dictionary = ["phone": tele,
                            "password":password,
                            "verify_code": verify_code,
                            "referrer_id": referrer_id]
                //发送注册请求
                Alamofire.request(RegisterURL, method: .post, parameters: para, encoding: JSONEncoding.default).responseJSON { (response) in
                    if(response.result.isSuccess) {
                        let dic = response.result.value as? [String: AnyObject]
                        if (dic!["result"] as! String != "success"){
                            let alertController = UIAlertController(title: nil,
                                                                    message: dic!["result"] as! String, preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            isLogin = true
                            userInfo.id = String(format: "%d", (dic!["id"] as! Int))
                            userInfo.phone = dic!["phone"] as! String
                            userMesaage = dic
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        print(response.debugDescription)
                    }
                }
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
