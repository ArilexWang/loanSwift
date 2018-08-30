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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.getSignalFromSelfDetailMsgTVC(controller: self, indexPath: indexPath)
        }
    }


}
