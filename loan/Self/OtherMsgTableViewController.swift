//
//  OtherMsgTableViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/29.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class OtherMsgTableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }

    



}
