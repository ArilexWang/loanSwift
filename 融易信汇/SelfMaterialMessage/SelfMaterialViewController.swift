//
//  SelfMaterialViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Alamofire

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

    @IBAction func submitBtnClick(_ sender: UIButton) {
        userMesaage!["position"] = self.materialMsgTVC?.positionNameTF.text
        userMesaage!["company_name"] = self.materialMsgTVC?.companyNameTF.text
        userMesaage!["residential_address"] = self.materialMsgTVC?.homeDistrictBtn.titleLabel?.text
        userMesaage!["company_address"] = self.materialMsgTVC?.districtBtn.titleLabel?.text
        userMesaage!["company_detailed_add"] = self.materialMsgTVC?.companyAdressDetail.text
        userMesaage!["working_year"] = self.materialMsgTVC?.workYearTF.text
        userMesaage!["mon_salary"] = self.materialMsgTVC?.monthlyIncomeTF.text
        userMesaage!["residential_detailed_add"] = self.materialMsgTVC?.homeAddressDetailTF.text
        
        userMesaage!["dr_name"] = self.immediateFamilyTVC?.nameTF.text
        userMesaage!["dr_relationship"] = self.immediateFamilyTVC?.relationshipTF.text
        userMesaage!["dr_phone"] = self.immediateFamilyTVC?.phoneNumberTF.text
        
        userMesaage!["oc_name"] = self.neighborRelativeTVC?.nameTF.text
        userMesaage!["oc_relationship"] = self.neighborRelativeTVC?.relationshipTF.text
        userMesaage!["oc_phone"] = self.neighborRelativeTVC?.phoneNumberTF.text
        
        
        
        
        Alamofire.request(UpdateUserInfoURL, method: .post, parameters: userMesaage, encoding: JSONEncoding.default).responseJSON { (response) in
            if(response.result.isSuccess) {
                let dic = response.result.value as? [String: AnyObject]
                if (dic!["result"] as! String != "success"){
                    let alertController = UIAlertController(title: nil,
                                                            message: dic!["result"] as! String, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                print(response.debugDescription)
            }
        }
        
    }
    

}
