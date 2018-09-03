//
//  SelfMaterialMessageTableViewController.swift
//  loan
//
//  Created by alexzwang on 2018/9/3.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import MJExtension


class SelfMaterialMessageTableViewController: UITableViewController,ActionSheetCustomPickerDelegate {
    
    var picker: ActionSheetCustomPicker?
    
    var homePicker: ActionSheetCustomPicker?

    var index1:Int = 0  //省下标
    var index2:Int = 0  //市下标
    var index3:Int = 0  //区下标
    
    var addressArr: [Dictionary<String,Array<Dictionary<String,Array<String>>>>]?
    var provinceArr = [String]()
    var districtArr = [String]()
    var cityArr =  [String]()
    
    @IBOutlet weak var homeDistrictBtn: UIButton!
    @IBOutlet weak var districtBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        calclateFirstData()

      
    }
    
    func loadFirstData(){
        if let filepath = Bundle.main.path(forResource: "address", ofType: "json") {
            do {
                let jsonStr = try String(contentsOfFile: filepath)
                self.addressArr = jsonStr.mj_JSONObject() as? [Dictionary<String,Array<Dictionary<String,Array<String>>>>]
                
                var firstNames = [String]()
                for item in self.addressArr!{
                    let name = (item as! Dictionary<String,Any>).keys.first
                    firstNames.append(name!)
                }
                self.provinceArr = firstNames
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
    }
    
    func calclateFirstData(){
        self.loadFirstData()
        
        var cityNames = [String]()
        for dic in (((self.addressArr![self.index1]).values.first) as! [Any]) {
            let name = (dic as! Dictionary<AnyHashable,Any>).keys.first
            cityNames.append(name as! String)
        }
        self.cityArr = cityNames
        self.districtArr = ((((self.addressArr![self.index1].values.first)?[self.index2])?.values)?.first)!
    }
    
    
    
    
    @IBAction func companyDistinctBtnClick(_ sender: UIButton) {
        self.picker = ActionSheetCustomPicker.init(title: "选择地区", delegate: self, showCancelButton: true, origin: self.view, initialSelections: [self.index1,self.index2,self.index3])
        self.picker?.tapDismissAction = TapAction.success
        
        let cusCancelBtn = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        let cusDoneBtn = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        self.picker?.setCancelButton(cusCancelBtn)
        self.picker?.setDoneButton(cusDoneBtn)
        self.picker?.show()
    }
    
    
    @IBAction func homeDistinctBtnClick(_ sender: UIButton) {
        self.homePicker = ActionSheetCustomPicker.init(title: "选择地区", delegate: self, showCancelButton: true, origin: self.view, initialSelections: [self.index1,self.index2,self.index3])
        self.homePicker?.tapDismissAction = TapAction.success
        
        let cusCancelBtn = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        let cusDoneBtn = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        self.homePicker?.setCancelButton(cusCancelBtn)
        self.homePicker?.setDoneButton(cusDoneBtn)
        self.homePicker?.show()
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.provinceArr.count
        case 1:
            return self.cityArr.count
        case 2:
            return self.districtArr.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (component)
        {
        case 0:
            return self.provinceArr[row]
        case 1:
            return self.cityArr[row]
        case 2:
            return self.districtArr[row]
        default:
            break;
        }
        return nil;
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.index1 = row
            self.index2 = 0
            self.index3 = 0
            self.calclateFirstData()
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        case 1:
            self.index2 = row
            self.index3 = 0
            self.calclateFirstData()
            pickerView .selectRow(0, inComponent: 2, animated: true)
            pickerView.reloadComponent(2)
        case 2:
            self.index3 = row
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        var title = ""
        switch (component)
        {
        case 0:
            title = self.provinceArr[row]
        case 1:
            title = self.cityArr[row]
        case 2:
            title = self.districtArr[row]
        default:
            break;
        }
        label.textAlignment = .center
        label.text = title
        
        return label
    }
    
    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        var detailAddress = ""
        
        if(self.index1 < self.provinceArr.count){
            detailAddress += self.provinceArr[self.index1]  + " "
        }
        if self.index2 < self.cityArr.count {
            detailAddress += self.cityArr[self.index2] + " "
        }
        if self.index3 < self.districtArr.count {
            detailAddress += self.districtArr[self.index3]
        }
        
        if actionSheetPicker == self.picker{
            districtBtn.setTitle(detailAddress, for: .normal)
            districtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        } else {
            homeDistrictBtn.setTitle(detailAddress, for: .normal)
            homeDistrictBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        
        
    }
    
    
}
