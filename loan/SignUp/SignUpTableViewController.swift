//
//  SignUpTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/23.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var ImgCodeView: NNValidationView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var imageCodeTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var referrerIDTF: UITextField!
    
    var countdownTimer: Timer?
    
    var isPhoneNumberCorrect:Bool = false {
        didSet {
            if isPhoneNumberCorrect,isImageCodeCorrect {
                enableSendBtn()
            }
        }
    }
    
    var isImageCodeCorrect:Bool = false {
        didSet {
            if isPhoneNumberCorrect,isImageCodeCorrect {
                enableSendBtn()
            }
        }
    }
    
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
    
    func enableSendBtn(){
        sendButton.isUserInteractionEnabled = true
        sendButton.setTitleColor(#colorLiteral(red: 0.137254902, green: 0.7490196078, blue: 0.9882352941, alpha: 1), for: .normal)
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        isCounting = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImgCodeView.setCharNumAndLine(4, 4)
        phoneNumberTF.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(_:)), for: .editingChanged)
        imageCodeTF.addTarget(self, action: #selector(imageCodeTextFieldDidChange(_:)), for: .editingChanged)

    }


    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField){
        if let _ = Int(textField.text!),textField.text?.count == 11 {
            isPhoneNumberCorrect = true
        }
        
    }
    
    @objc func imageCodeTextFieldDidChange(_ textField: UITextField){
        if (textField.text == (ImgCodeView?.charString! as! String)){
            isImageCodeCorrect = true
        }
        
    }

}
