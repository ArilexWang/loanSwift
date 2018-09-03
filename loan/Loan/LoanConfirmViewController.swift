//
//  LoanConfirmViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit



class LoanConfirmViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }



}
