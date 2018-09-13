//
//  LoanMsgTableViewCell.swift
//  loan
//
//  Created by Ricardo on 2018/9/7.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class LoanMsgTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var moneyLable: UILabel!
    
    @IBOutlet weak var eachMonthMoneyLable: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
