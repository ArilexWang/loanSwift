//
//  LoanMsg.swift
//  loan
//
//  Created by Ricardo on 2018/9/1.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import Foundation

struct LoanMsg {
    var loanNum: Int?
    
    var loanMonth: Int?
    
    var payback: Int?
    
    var interest: Int?
    
    var actualMoney: Int?
    
    init(loanNum: Int,loanMonth: Int,payback: Int, interest: Int, actualMoney: Int) {
        self.loanNum = loanNum
        self.loanMonth = loanMonth
        self.payback = payback
        self.interest = interest
        self.actualMoney = actualMoney
    }
    
    
}
