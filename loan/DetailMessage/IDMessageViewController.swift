//
//  IDMessageViewController.swift
//  loan
//
//  Created by Ricardo on 2018/9/2.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import UIKit
import Photos
import Alamofire
import NVActivityIndicatorView

class IDMessageViewController: UIViewController,UINavigationControllerDelegate , UIImagePickerControllerDelegate,NVActivityIndicatorViewable {

    @IBOutlet weak var frontIDBtn: UIButton!
    var frontImgUrl: String?
    
    @IBOutlet weak var backIDBtn: UIButton!
    var backImgUrl: String?
    
    @IBOutlet weak var holdIDBtn: UIButton!
    var holdImgUrl: String?
    
    var flag = 0
    
    var frontIDImage: UIImage?
    var frontIDImageURL: String?
    var backIDImage: UIImage?
    var holdIDImage: UIImage?
    
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    
    @IBAction func frontIDBtnClick(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        flag = 0
        self.present(image, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let now = Date()
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            let timeString = String(format: "%d", timeStamp)
            let uploader: QNUploadManager = QNUploadManager()
            let token = createQiniuToken(fileName: timeString)
            let data = UIImagePNGRepresentation(image)
            self.view.alpha = 0.8
            self.view.isUserInteractionEnabled = false
            loadingView.startAnimating()
            uploader.put(data, key: timeString, token: token, complete: { (info, key, resp) in
                if (info?.statusCode == 200){
                    self.view.alpha = 1
                    self.view.isUserInteractionEnabled = true
                    self.loadingView.stopAnimating()
                    let url = ImageBaseURL + (resp!["key"] as! String) + ImageStyleURL
                    if(self.flag == 0){
                        self.frontImgUrl = url
                    } else if(self.flag == 1){
                        self.backImgUrl = url
                    } else {
                        self.holdImgUrl = url
                    }
                }
            }, option: nil)
            
            if(flag == 0){
                self.frontIDBtn.setImage(image, for: .normal)
                frontIDImage = image
            } else if(flag == 1){
                self.backIDBtn.setImage(image, for: .normal)
                frontIDImage = image
            } else {
                self.holdIDBtn.setImage(image, for: .normal)
                holdIDImage = image
            }
            
        } else {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backIDBtnClick(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        flag = 1
        self.present(image, animated: true)
        
    }
    @IBAction func holdIDBtnClick(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        flag = 2
        self.present(image, animated: true)
        
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        
        if (frontImgUrl != nil) && (backImgUrl != nil) && (holdImgUrl != nil) {
            if userMesaage!["card_front_pic_url"] != nil {
                userMesaage!["card_front_pic_url"] = frontImgUrl
            }
            if userMesaage!["card_back_pic_url"] != nil {
                userMesaage!["card_back_pic_url"] = backImgUrl
            }
            if userMesaage!["card_hand_pic_url"] != nil {
                userMesaage!["card_hand_pic_url"] = holdImgUrl
            }
            if userMesaage!["user_name"] != nil {
                userMesaage!["user_name"] = idMessageTVC?.nameTF.text
            }
            if userMesaage!["id_card_num"] != nil {
                userMesaage!["id_card_num"] = idMessageTVC?.idNumTF.text
            }
            
            print(userMesaage)
            
            Alamofire.request(UpdateUserInfoURL, method: .post, parameters: userMesaage, encoding: JSONEncoding.default).responseJSON { (response) in
                if(response.result.isSuccess) {
                    let dic = response.result.value as? [String: AnyObject]
                    if (dic!["result"] as! String != "success"){
                        print(dic)
                        let alertController = UIAlertController(title: nil,
                                                                message: dic!["result"] as! String, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        print(dic)
                    }
                } else {
                    print(response.debugDescription)
                }
            }
            
        } else {
            let alertController = UIAlertController(title: nil,
                                                    message: "信息未填完整", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    var idMessageTVC: IDMessageTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedToOwner":
            self.idMessageTVC = segue.destination as? IDMessageTableViewController
        default:
            break
        }
    }
    
}
