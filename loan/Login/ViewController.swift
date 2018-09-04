//
//  ViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/22.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginWithCellphoneNumberContentTableView: UIView!
    
    @IBOutlet weak var loginByPassword: UIView!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    var loginByPhoneNumberTVC: LoginByPhoneNumberTableViewController?
    
    var loginByAccount: LoginByPasswordTableViewController?
    
    var loginFlag = true //为true时短信验证登录，为false时账号密码登录
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        let titles = ["手机号快捷登录", "账号密码登录"]
        let frame = CGRect(x: 5, y: 170, width: view.frame.width - 10, height: 60)
        
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        
        view.addSubview(segmentedControl)
        
        loginByPassword.isHidden = true
        
        
    }
    

    
    //登录点击事件
    @IBAction func signinBtnClick(_ sender: UIButton) {
        
        let account = self.loginByAccount?.accountTextField.text
        let password = self.loginByAccount?.passwordTextField.text
        
        
        let phone = self.loginByPhoneNumberTVC?.phoneNumber.text
        let code = self.loginByPhoneNumberTVC?.msgCode.text
        
        let para:Dictionary = [
            "phone": account,
            "password": password,
            "login_manner": "password"
        ]
        
        let messagePara = [
            "phone" : phone,
            "login_manner": "code",
            "verify_code":"3099"
        ]
        
        //账号密码登录
        if !loginFlag {
            Alamofire.request(LoginURL, method: .post, parameters: para, encoding: JSONEncoding.default).responseJSON { (response) in
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
        } else {  //短信快捷登录
            SMSSDK.commitVerificationCode(code, phoneNumber: phone, zone: "86") { (error) in
                //验证成功
                if (error.debugDescription == "nil"){
                    
                    //发送登录请求
                    Alamofire.request(LoginURL, method: .post, parameters: messagePara, encoding: JSONEncoding.default).responseJSON { (response) in
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
    }
    
    //注册点击事件
    @IBAction func signupBtnClcik(_ sender: UIButton) {
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "loginByPhoneNumber":
            self.loginByPhoneNumberTVC = segue.destination as? LoginByPhoneNumberTableViewController
        case "loginByAccount":
            self.loginByAccount = segue.destination as? LoginByPasswordTableViewController
            
        case "segueToSignUp":
            navigationItem.title = ""
        default:
            break
        }
    }
    
    
    
}

extension ViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        switch segmentIndex {
        case 0:
            loginByPassword.isHidden = true
            loginWithCellphoneNumberContentTableView.isHidden = false
            signUpBtn.isHidden = false
            loginFlag = true
        case 1:
            loginByPassword.isHidden = false
            loginWithCellphoneNumberContentTableView.isHidden = true
            signUpBtn.isHidden = true
            loginFlag = false
        default:
            break
        }
    }
}
