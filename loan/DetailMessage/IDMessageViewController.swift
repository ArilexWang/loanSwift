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

class IDMessageViewController: UIViewController,UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    @IBOutlet weak var frontIDBtn: UIButton!
    
    @IBOutlet weak var backIDBtn: UIButton!
    
    @IBOutlet weak var holdIDBtn: UIButton!
    var flag = 0
    
    var frontIDImage: UIImage?
    var frontIDImageURL: String?
    var backIDImage: UIImage?
    var holdIDImage: UIImage?
    
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
            if(flag == 0){
                self.frontIDBtn.setImage(image, for: .normal)
                frontIDImage = image
                let fileManager = FileManager.default
                let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                   .userDomainMask, true)[0] as String
                let filePath = "\(rootPath)/pickedimage.jpg"
                let imageData = UIImageJPEGRepresentation(frontIDImage!, 1.0)
                fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
                frontIDImageURL = filePath
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
        let uploader: QNUploadManager = QNUploadManager()
        let token = createQiniuToken(fileName: "")
        let data = UIImagePNGRepresentation(frontIDImage!)
        uploader.put(data, key: "", token: token, complete: { (info, key, resp) in
            print(info?.statusCode)
        }, option: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
