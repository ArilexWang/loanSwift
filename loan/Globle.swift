//
//  Globle.swift
//  loan
//
//  Created by Ricardo on 2018/9/1.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import Foundation
import JSONKit_NoWarning
import Qiniu

var userInfo = UserInfo()

var isLogin = false

var userMesaage: Dictionary<String, Any>?


let kQiniuBucket = "qiniubucket"
let kQiniuAccessKey = "93L43E91oA1cbC9k40ZK2eSeOCqxxjJz1SsL4NGv"
let kQiniuSecretKey = "2nALux7vEJkrcuH0ZOWUhW2bI6vIvvtqpysS71aH"

func hmacsha1WithString(str: String, secretKey: String) -> NSData {
    
    let cKey  = secretKey.cString(using: String.Encoding.ascii)
    let cData = str.cString(using: String.Encoding.ascii)
    
    var result = [CUnsignedChar](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
    CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
    let hmacData: NSData = NSData(bytes: result, length: (Int(CC_SHA1_DIGEST_LENGTH)))
    return hmacData
}

func createQiniuToken(fileName: String) -> String {
    
    let oneHourLater = NSDate().timeIntervalSince1970 + 3600
    // 上传策略中，只有scope和deadline是必填的
    let scope = (fileName.isEmpty) ? kQiniuBucket : kQiniuBucket + ":" + fileName;
    let putPolicy: NSDictionary = ["scope": scope, "deadline": NSNumber(value: UInt64(oneHourLater))]
    let encodedPutPolicy = QNUrlSafeBase64.encode(putPolicy.jsonString())
    let sign = hmacsha1WithString(str: encodedPutPolicy!, secretKey: kQiniuSecretKey) as! Data
    let encodedSign = QNUrlSafeBase64.encode(sign)
    
    return kQiniuAccessKey + ":" + encodedSign! + ":" + encodedPutPolicy!
}


let HOST = "http://212.64.32.162:3099/Loan/"

let LoginURL = "http://212.64.32.162:3099/Loan/login"

let RegisterURL = "http://212.64.32.162:3099/Loan/register"

let ResetPasswordURL = "http://212.64.32.162:3099/Loan/update_password"

