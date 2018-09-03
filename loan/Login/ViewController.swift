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
        
//        let account = self.loginByAccount?.accountTextField.text
//        let password = self.loginByAccount?.passwordTextField.text
        
        let para:Dictionary = [
            "phone": "13583923827",
            "password": "12345",
            "login_manner": "password"
        ]
        Alamofire.request("http://212.64.32.162:3099/Loan/login", method: .post, parameters: para, encoding: JSONEncoding.default).responseJSON { (response) in
            if(response.result.isSuccess) {
                isLogin = true
                let dic = response.result.value as? [String: AnyObject]
                userInfo.id = String(format: "%d", (dic!["id"] as! Int))
                userInfo.phone = dic!["phone"] as! String
                self.navigationController?.popViewController(animated: true)
            } else {
                print(response.debugDescription)
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
        case 1:
            loginByPassword.isHidden = false
            loginWithCellphoneNumberContentTableView.isHidden = true
            signUpBtn.isHidden = true
        default:
            break
        }
    }
}
