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
    
    
    @IBAction func confirmBtnClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil,
                                                message: "提现失败，资料正在审核中...", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



}
