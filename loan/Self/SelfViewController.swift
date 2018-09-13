//
//  SelfViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/29.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfViewController: UIViewController,GetSignalDelegate {
    
    @IBOutlet weak var lockImg: UIImageView!
    
    @IBOutlet weak var selfMsgContainView: UIView!
    
    @IBOutlet weak var otherMsgContainView: UIView!
    
    @IBOutlet weak var loginLbl: UILabel!
    var selfMsgTVC: SelfMsgTableViewController?
    
    var otherMsgTVC: OtherMsgTableViewController?
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLogin {
            otherMsgContainView.isHidden = false
            loginLbl.text = userInfo.phone
            lockImg.isUserInteractionEnabled = false
        } else {
            otherMsgContainView.isHidden = true
            loginLbl.text = "登录/注册"
            lockImg.isUserInteractionEnabled = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        lockImg.isUserInteractionEnabled = true
        lockImg.addGestureRecognizer(tapGestureRecognizer)
        
        if !isLogin {
            otherMsgContainView.isHidden = true
        }
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        performSegue(withIdentifier: "segueToLogin", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = ""
        switch segue.identifier {
        case "segueToSelfMsg":
            let destinationVC = segue.destination as? SelfMsgTableViewController
            self.selfMsgTVC = destinationVC
            destinationVC?.delegate = self
        case "segueToOtherMsg":
            let des = segue.destination as? OtherMsgTableViewController
            des?.delegate = self
            self.otherMsgTVC = des
         default:
            break
        }
    }
    
    //修改密码，退出登录
    func getSignal(controller: OtherMsgTableViewController, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "segueToResetPassword", sender: nil)
        case 1:
            let alertController = UIAlertController(title: nil,
                                                    message: "确定要退出当前账号吗", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                isLogin = false
                userMesaage = nil
                isPerfect = false
                self.performSegue(withIdentifier: "segueToLogin", sender: nil)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    //我的资料，我的借款，我的还款
    func getSignalFromSelfTVC(controller: SelfMsgTableViewController, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if isLogin {
                performSegue(withIdentifier: "segueToSelfMsgVC", sender: nil)
            } else {
                performSegue(withIdentifier: "segueToLogin", sender: nil)
            }
            
        case 1:
            if isLogin {
                performSegue(withIdentifier: "segueToLoanListTVC", sender: nil)
            } else {
                performSegue(withIdentifier: "segueToLogin", sender: nil)
            }
        case 2:
            if isLogin {
                performSegue(withIdentifier: "segueToPayback", sender: nil)
            } else {
                performSegue(withIdentifier: "segueToLogin", sender: nil)
            }
        default:
            break
        }
    }
    

}
