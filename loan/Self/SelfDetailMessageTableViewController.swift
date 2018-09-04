//
//  SelfDetailMessageTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

protocol SelfMessageVCGetSignalDelegate:NSObjectProtocol {
    func getSignalFromSelfDetailMsgTVC(controller: SelfDetailMessageTableViewController, indexPath: IndexPath)
}


class SelfDetailMessageTableViewController: UITableViewController {
    
    var delegate: SelfMessageVCGetSignalDelegate?
    
    @IBOutlet weak var idMessageLable: UILabel!
    
    @IBOutlet weak var materialMessageLable: UILabel!
    
    @IBOutlet weak var creditCardLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userMesaage)
        if (userMesaage!["detailed_info"] as! Bool)  {
            materialMessageLable.text = "已填写"
            materialMessageLable.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1)
        }
        if (userMesaage!["verified_info"] as! Bool)  {
            idMessageLable.text = "已填写"
            idMessageLable.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1)
        }
        if (userMesaage!["bank_card_info"] as! Bool)  {
            creditCardLable.text = "已填写"
            creditCardLable.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.getSignalFromSelfDetailMsgTVC(controller: self, indexPath: indexPath)
        }
    }


}
