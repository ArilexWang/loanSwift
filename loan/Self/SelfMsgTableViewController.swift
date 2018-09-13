//
//  SelfMsgTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/29.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfMsgTableViewController: UITableViewController {
    
    var delegate: GetSignalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.getSignalFromSelfTVC(controller: self, indexPath: indexPath)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
