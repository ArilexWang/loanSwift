//
//  ViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/22.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import TwicketSegmentedControl

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
