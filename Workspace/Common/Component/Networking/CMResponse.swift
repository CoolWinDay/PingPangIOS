//
//  CMRequestModel.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/8.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CMResponse: HandyJSON {
    var json: JSON?
    var error: Error?
    var fileUrl: URL?
    
    var errorCode = ""
    var errorInfo = "请求错误"
    
    required init() {}
    
    func isSuccess() -> Bool {
        return errorCode == "00000000"
    }
}
