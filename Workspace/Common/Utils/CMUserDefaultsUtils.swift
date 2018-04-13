//
//  CMUserDefaultsUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    // update
    public static let UDKey_UpdateType = "UDKey_UpdateType"
    public static let UDKey_UpdateVersion = "UDKey_UpdateVersion"
    
    public static let UDValue_UpdateTypeForce = "UDValue_UpdateTypeForce"
    public static let UDValue_UpdateTypeOptional = "UDValue_UpdateTypeOptional"
    public static let UDValue_UpdateTypeNone = "UDValue_UpdateTypeNone"
    
    class func setUserDefaultsString(_ string: String?, forKey: String) {
        let udf = UserDefaults.standard
        udf.set(string, forKey: forKey)
        udf.synchronize()
    }
    
    class func getUserDefaultsString(_ forKey: String) -> String? {
        let udf = UserDefaults.standard
        let object = udf.object(forKey: forKey)
        if let string = object as? String {
            return string
        }
        return nil
    }
    
    class func setUserDefaults(_ object: Any?, forKey: String) {
        let udf = UserDefaults.standard
        udf.set(object, forKey: forKey)
        udf.synchronize()
    }
    
    class func getUserDefaults(_ forKey: String) -> Any? {
        let udf = UserDefaults.standard
        return udf.object(forKey: forKey)
    }
}

class CMUserDefaultsUtils: NSObject {
    
}
