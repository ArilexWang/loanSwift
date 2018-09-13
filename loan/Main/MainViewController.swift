//
//  MainViewController.swift
//  loan
//
//  Created by Ricardo on 2018/8/30.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    let cellSizes = Array( repeatElement(CGSize(width:55, height:34), count: 5))
    let cellTexts = ["6月","12月","18月","24月","36月"]
    let cellValues = [6,12,18,24,36]
    var loanNum: Float = 10000.0
    var loanMonth: Int = 6
    var interest: Float = 70.00
    var eachValue: Int = 1737
    
    
    @IBOutlet weak var monthCollectionView: UICollectionView!{
        didSet{
            monthCollectionView.dataSource = self
            monthCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var numSlider: DesignableSlider!
    
    @IBAction func sliderValueChanged(_ sender: DesignableSlider) {
        let num = roundf(numSlider.value/1000.0) * 1000
        let numStr:String = String(format: "%.2f", num)
        
        bigNumLbl.text = numStr
        smallNumLbl.text = numStr
        
        loanNum = num
        
        interest = num * 0.007
        interestLbl.text = String(format: "%.2f", interest)
        
        eachValue = Int(ceilf(loanNum/Float(loanMonth)) + interest)
        eachMonthValue.text = String(format: "%d", eachValue)
    }
    @IBOutlet weak var interestLbl: UILabel!
    
    @IBOutlet weak var eachMonthValue: UILabel!
    
    @IBOutlet weak var bigNumLbl: UILabel!
    
    @IBOutlet weak var smallNumLbl: UILabel!
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

    }
    
    
    @IBAction func loanBtnClick(_ sender: UIButton) {
        if(userMesaage != nil){
            if ((userMesaage!["detailed_info"] as! Int) != 0)
                && ((userMesaage!["verified_info"] as! Int) != 0)
                && ((userMesaage!["bank_card_info"] as! Int) != 0)
            {
                isPerfect = true
            }
        }
        
        
        if (isLogin && isPerfect) {
            performSegue(withIdentifier: "segueToConfirmLoan", sender: nil)
        } else if !isLogin {
            performSegue(withIdentifier: "mainSegueToLogin", sender: nil)
        } else {
            
            performSegue(withIdentifier: "mainSegueToInfo", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = ""
        switch segue.identifier {
        case "segueToConfirmLoan":
            let destinationVC = segue.destination as! LoanConfirmViewController
            let loanMsg = LoanMsg(loanNum: Int(loanNum), loanMonth: loanMonth, payback: Int(loanNum), interest: Int(interest), actualMoney: Int(loanNum))
            DispatchQueue.main.async {
                destinationVC.loanMsg = loanMsg
            }
            
        default:
            break
        }
    }
    
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cells = collectionView.visibleCells as! [MonthCollectionViewCell]
        for cell in cells {
            cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
            cell.monthLbl.textColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        }
        
        if let monthCell = collectionView.cellForItem(at: indexPath) as? MonthCollectionViewCell {
            monthCell.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.7490196078, blue: 0.9882352941, alpha: 1)
            monthCell.monthLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        loanMonth = cellValues[indexPath.row]
        eachValue = Int(ceilf(loanNum/Float(loanMonth)) + interest)
        eachMonthValue.text = String(format: "%d", eachValue)
    }

    //datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCell", for: indexPath)
        if let monthCell = cell as? MonthCollectionViewCell {
            monthCell.monthLbl.text = cellTexts[indexPath.row]
            if indexPath.row == 0 {
                monthCell.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.7490196078, blue: 0.9882352941, alpha: 1)
                monthCell.monthLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        return cell
    }
}
