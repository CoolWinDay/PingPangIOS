//
//  CMAppUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/27.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import SwiftyJSON
import Toast_Swift
import AVFoundation
import AssetsLibrary
import CoreLocation

typealias VoidCallback = () -> ()
typealias StringCallback = (String) -> ()

func cmMainWindow() -> UIWindow? {
    if let window = cmDelegate().window {
        return window
    }
    
    let windows = UIApplication.shared.windows
    if windows.count == 1 {
        return windows.first
    }
    else {
        for window in windows {
            if window.windowLevel == UIWindowLevelNormal {
                return window
            }
        }
    }
    return nil
}

func cmTopMostViewController() -> UIViewController? {
    
    func topViewController(_ vc: UIViewController?) -> UIViewController? {
        if let topVC = vc as? UINavigationController {
            return topViewController(topVC.visibleViewController)
        }
        if let topVC = vc as? UITabBarController {
            return topViewController(topVC.selectedViewController)
        }
        if let topVC = vc?.presentedViewController {
            return topViewController(topVC)
        }
        return vc
    }
    
    return topViewController(cmMainWindow()?.rootViewController)
}

func cmDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

func cmRootNavigationController() -> UINavigationController {
    return UIApplication.shared.windows[0].rootViewController as! UINavigationController
}

func cmPushViewController(_ vc: Any?, setVC: ((UIViewController) -> ())? = nil) {
    if let vcName = vc as? String {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
//      let classStringName = "_TtC\(appName!.characters.count)\(appName!)\(className.characters.count)\(className)"
        let vcClass: AnyClass? = NSClassFromString("\(appName!).\(vcName)")
        let vcInstance: UIViewController? = (vcClass as? UIViewController.Type)?.init()
        cmPushViewController(vcInstance, setVC: setVC)
    }
    else if let vcInstance = vc as? UIViewController {
        setVC?(vcInstance)
        cmRootNavigationController().pushViewController(vcInstance, animated: true)
    }
}

func cmPopViewController() {
    cmRootNavigationController().popViewController(animated: true)
}

func cmShowLogin(animated: Bool) {
    let loginVC = LoginVC()
    cmRootNavigationController().present(loginVC, animated: animated) {
        
    }
}

func cmCacheUrl(name: String) -> URL {
    var cacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
        cacheUrl = cacheUrl.appendingPathComponent(appName)
    }
    return cacheUrl.appendingPathComponent(name)
}

func cmShowToast(_ toast: String?, position: Toast_Swift.ToastPosition = ToastManager.shared.position) {
    if let theToast = toast {
        cmMainWindow()?.makeToast(theToast, duration: ToastManager.shared.duration, position: position)
    }
}

func cmShowLoading() {
    if let view = cmTopMostViewController()?.view {
        LGProgressHUD.showHud(IndeficatorType: LGProgressIndeficatorType.system, view: view)
    }
}

func cmHideLoading() {
    if let view = cmTopMostViewController()?.view {
        LGProgressHUD.dismiss(view)
    }
}

// 相机权限
func isRightCamera() -> Bool {
    let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    return authStatus != .restricted && authStatus != .denied
}

// 相册权限
func isRightPhoto() -> Bool {
    let authStatus = ALAssetsLibrary.authorizationStatus()
    return authStatus != .restricted && authStatus != .denied
}

// 麦克风权限
func isRightMicroPhone() -> Bool {
    var result: Bool = false
    AVAudioSession.sharedInstance().requestRecordPermission({(_ granted: Bool) -> Void in
        result = granted
    })
    return result
}

// 定位权限
func isRightLocation() -> Bool {
    let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
    return CLLocationManager.locationServicesEnabled() && (authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse || authStatus == .notDetermined)
}

// 跳转到系统设置权限界面
func goSettings() {
    let settingsUrl:URL = NSURL(string: UIApplicationOpenSettingsURLString)! as URL
    if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.openURL(settingsUrl)
    }
}

class CMAppUtils: NSObject {
    
}
