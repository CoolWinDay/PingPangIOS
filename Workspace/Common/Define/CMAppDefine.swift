//
//  CMAppDefine.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/14.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

enum AppModeType {
    case Daily, PreRelease, Release
}

//// --------------------- 开发环境 ----------------------
let AppMode: AppModeType = AppModeType.Daily


//// --------------------- server ----------------------
let ServerAddress: String = "https://api.douban.com"


//// --------------------- keys ----------------------
// SMSSDK 
let kSMSAppKey: String = "173f87709381d"
let kSMSAppSecrect: String = "69988802391e4d4be0214cbfd1dc7299"

// umeng
let kUmengAppKey: String = "69988802391e4d4be0214cbfd1dc7299"

