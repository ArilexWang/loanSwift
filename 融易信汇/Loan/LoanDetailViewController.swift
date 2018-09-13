//
//  LoanDetailViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class LoanDetailViewController: UIViewController {

    @IBOutlet weak var idLable: UILabel!
    
    @IBOutlet weak var moneyLable: UILabel!
    
    @IBOutlet weak var monthLable: UILabel!
    
    @IBOutlet weak var bigMoneyLable: UILabel!
    
    @IBOutlet weak var eachMonthMoneyLable: UILabel!
    
    var loanMsg: LoanMsg? {
        didSet{
            DispatchQueue.main.async {
                self.moneyLable?.text = String(format: "%d", (self.loanMsg?.loanNum)!)
                self.monthLable?.text = String(format: "%d", (self.loanMsg?.loanMonth)!)
                self.bigMoneyLable?.text = String(format: "%d", (self.loanMsg?.payback)!)
                let each = Int(ceilf(Float((self.loanMsg?.loanNum)!/(self.loanMsg?.loanMonth)!)) + Float((self.loanMsg?.interest)!))
                self.eachMonthMoneyLable?.text = String(format: "%d", each)
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



}
