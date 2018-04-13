//
//  WXApiManager.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/26.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

@objc protocol WXAuthDelegate {
    @objc optional func wxAuthSucceed(code: String)
    @objc optional func wxAuthDenied()
    @objc optional func wxAuthCancel()
}

class WXApiManager: NSObject, WXApiDelegate {
    
    var authState: String = ""
    var delegate : WXAuthDelegate?
    
    // 单例
    static let sharedInstance = WXApiManager()
    override private init() {
        super.init()
    }
    
    func wxLogin(delegate: WXAuthDelegate) {
        self.delegate = delegate
        
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = String.random()
        self.authState = req.state
        //第三方向微信终端发送一个SendAuthReq消息结构
        WXApi.sendAuthReq(req, viewController: cmTopMostViewController(), delegate: self)
    }
    
    func onReq(_ req: BaseReq!) {
        //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    }
    
    func onResp(_ resp: BaseResp!) {
        //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
        if let authResp = resp as? SendAuthResp {
            if let state = authResp.state {
                if state != self.authState {
                    // denied
                    delegate?.wxAuthDenied?()
                    return;
                }
            }
            
            switch resp.errCode {
            case WXSuccess.rawValue:
                delegate?.wxAuthSucceed?(code: authResp.code)
                break;
            case WXErrCodeAuthDeny.rawValue:
                delegate?.wxAuthDenied?()
                break;
            case WXErrCodeUserCancel.rawValue:
                delegate?.wxAuthCancel?()
                break;
            default:
                break;
            }
        }
    }
}
