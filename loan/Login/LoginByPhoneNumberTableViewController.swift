//
//  LoginByPhoneNumberTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/22.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class LoginByPhoneNumberTableViewController: UITableViewController {

    @IBOutlet weak var sendButton: UIButton!
    var countdownTimer: Timer?
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var imageCode: UITextField!
    
    @IBOutlet weak var msgCode: UITextField!

    @IBOutlet weak var codeViewRef: NNValidationView!
    
    var codeView: NNValidationView?
    
    var remainingSeconds: Int = 0 {
        willSet {
            sendButton.titleLabel?.text = "(\(newValue)s)"
            sendButton.setTitle("(\(newValue)s)", for: .normal)
            
            if newValue <= 0 {
                sendButton.titleLabel?.text = "重新获取"
                sendButton.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LoginByPhoneNumberTableViewController.updateTime(_:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 5
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                

            }
            
            sendButton.isEnabled = !newValue
        }
    }
    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        isCounting = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.isUserInteractionEnabled = false
        
        let iframe = imageCode.frame;
        
        codeViewRef.setCharNumAndLine(4, 4)
        
        print(codeViewRef.charString)

        weak var weakSelf = self;
        /// 返回验证码数字
        codeViewRef.changeValidationCodeBlock = {
            print("验证码被点击了：%@", weakSelf?.codeViewRef.charString ?? " ")
        }
        
    }



}
