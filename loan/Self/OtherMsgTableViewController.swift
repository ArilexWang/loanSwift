//
//  OtherMsgTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/29.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit


protocol GetSignalDelegate:NSObjectProtocol
{
    func getSignal(controller: OtherMsgTableViewController, indexPath: IndexPath)
    func getSignalFromSelfTVC(controller: SelfMsgTableViewController, indexPath: IndexPath)
}

class OtherMsgTableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    var delegate: GetSignalDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if((delegate) != nil){
            delegate?.getSignal(controller: self,indexPath: indexPath)
        }
    }

    



}
