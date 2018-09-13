//
//  LoanListViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Alamofire

class LoanListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectLoan: LoanMsg?
    var selectID: String?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "我的借款"
    }
    
    var loans: Array<Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        let para = [
            "user_id": userMesaage!["id"]
        ]
        
        Alamofire.request(GetLoansURL, method: .post, parameters: para, encoding: JSONEncoding.default).responseJSON { (response) in
            if(response.result.isSuccess) {
                var dic = response.result.value as? [Any]
                let last = dic?.last as! [String: String]
                if (last["result"] != "success"){
                    let alertController = UIAlertController(title: nil,
                                                            message: last["result"], preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    dic?.popLast()
                    self.loans = dic
                    self.tableView.reloadData()
                }
            } else {
                
                print(response.debugDescription)
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let num = loans?.count {
            return num
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanMsg", for: indexPath)
        
        if((loans?.count)! > 0){
            let loan = self.loans![indexPath.row] as! Dictionary<String, Any>
            
            if let loanCell = cell as? LoanMsgTableViewCell {
                loanCell.idLabel.text = loan["id"] as? String
                loanCell.moneyLable.text = loan["amount"] as? String
                loanCell.monthLabel.text = loan["period"] as? String
                let total = Float(loan["amount"] as! String)
                let months = Float(loan["period"] as! String)
                let interest = total! * 0.007
                let each = Int(ceilf(total!/months!) + interest)
                loanCell.eachMonthMoneyLable.text = String(format: "%d", each)
                selectLoan = LoanMsg(loanNum: Int(total!), loanMonth: Int(months!), payback: Int(total!), interest: Int(interest), actualMoney: Int(total!))
                selectID = loan["id"] as? String
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToLoanDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = ""
        switch segue.identifier {
        case "segueToLoanDetailVC":
            let destin = segue.destination as! LoanDetailViewController
            DispatchQueue.main.async {
                destin.loanMsg = self.selectLoan
                destin.idLable.text = self.selectID
            }
            
        default:
            break
        }
    }
    

}
