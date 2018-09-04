//
//  ResetPasswordViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Alamofire


class ResetPasswordViewController: UIViewController {

    
    var resetPasswordTVC: ResetPasswordTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func submitBtnClick(_ sender: UIButton) {
        let code = self.resetPasswordTVC?.accessCodeTF.text
        let phone = self.resetPasswordTVC?.phoneNumberTF.text
        let password = self.resetPasswordTVC?.passwordTF.text
        
        let para = ["phone":phone,
                    "new_password":password,
                    "verify_code":"3099"]
        
        SMSSDK.commitVerificationCode(code, phoneNumber: phone, zone: "86") { (error) in
            //验证成功
            if (error.debugDescription == "nil"){
                //发送登录请求
                Alamofire.request(ResetPasswordURL, method: .post, parameters: para, encoding: JSONEncoding.default).responseJSON { (response) in
                    if(response.result.isSuccess) {
                        let dic = response.result.value as? [String: AnyObject]
                        if (dic!["result"] as! String != "success"){
                            let alertController = UIAlertController(title: nil,
                                                                    message: dic!["result"] as! String, preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            
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
        case "embedResetPasswordTVC":
            self.resetPasswordTVC = segue.destination as? ResetPasswordTableViewController
        default:
            break
        }
    }
    
    
    
}
