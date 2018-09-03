//
//  SelfMaterialViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class SelfMaterialViewController: UIViewController {
    
    var materialMsgTVC: SelfMaterialMessageTableViewController?
    var immediateFamilyTVC: SelfMaterialImmediateFamilyTableViewController?
    var neighborRelativeTVC: SelfMaterialNeighboringRelativeTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedImmediateFamilyTVC":
            self.immediateFamilyTVC = segue.destination as? SelfMaterialImmediateFamilyTableViewController
        case "embedMaterialMsgTVC" :
            self.materialMsgTVC = segue.destination as? SelfMaterialMessageTableViewController
        case "embedNeighborRelativeTVC":
            self.neighborRelativeTVC = segue.destination as? SelfMaterialNeighboringRelativeTableViewController
        default:
            break
        }
    }



}
