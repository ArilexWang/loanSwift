//
//  User.swift
//  loan
//
//  Created by Ricardo on 2018/9/1.
//  Copyright © 2018年 Ricardo. All rights reserved.
//

import Foundation

open class UserInfo: NSObject{
    open var phone: String
    open var id: String
    
    init?(data: NSDictionary?) {
        guard
            let phone = data?.value(forKey: UserKey.Phone) as? String,
            let id = data?.value(forKey: UserKey.ID) as? String
            else {
                return nil
        }
        
        self.phone = phone
        self.id = id
        
    }
    
    public override init() {
        self.phone = ""
        self.id = ""
    }
    
    struct UserKey {
        static let Phone = "phone"
        static let ID = "id"
    }
}
