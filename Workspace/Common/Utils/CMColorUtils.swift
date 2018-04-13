//
//  ColorUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/9.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexColor(hexString: String) -> UIColor {
        return CMColorUtils.colorWithHexString(hexColor: hexString)
    }
    
    class func hexColor(hexInteger: NSInteger) -> UIColor {
        return CMColorUtils.colorWithHex(hexColor: hexInteger)
    }
}

class CMColorUtils: NSObject {
    
    var colorsDict = Dictionary<String, UIColor>()
    
    // 单例
    static let sharedInstance = CMColorUtils()
    override private init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(onRecvMemoryWarning), name: Notification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func onRecvMemoryWarning() {
        CMColorUtils.sharedInstance.colorsDict.removeAll()
    }
    
    class func colorWithHexString(hexColor : String) -> UIColor {
        
        if hexColor.isEmpty {
            return UIColor.clear
        }
        
        // 先从缓存中取
        let colorUtils = CMColorUtils.sharedInstance
        if colorUtils.colorsDict[hexColor] != nil {
            let color: UIColor = colorUtils.colorsDict[hexColor]!
            return color
        }
        
        // 缓存没有实际生成
        var cString = hexColor.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        // String should be 6 or 8 characters
        if cString.characters.count < 6 {
            return UIColor.clear
        }
        
        // strip 0X if it appears
        if cString.hasPrefix("0X") || cString.hasPrefix("0x") {
            cString.remove(at: cString.startIndex)
            cString.remove(at: cString.startIndex)
        }
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.characters.count != 6 {
            return UIColor.clear
        }
        
        let rRange = cString.startIndex ..< cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(with: rRange)
        
        let gRange = cString.index(cString.startIndex, offsetBy: 2) ..< cString.index(cString.startIndex, offsetBy: 4)
        let gString = cString.substring(with: gRange)
        
        let bRange = cString.index(cString.startIndex, offsetBy: 4) ..< cString.index(cString.startIndex, offsetBy: 6)
        let bString = cString.substring(with: bRange)
        
        var r : UInt32  = 0
        var g : UInt32  = 0
        var b : UInt32  = 0
        let rScanner:Scanner = Scanner.localizedScanner(with: rString) as! Scanner
        rScanner.scanHexInt32(&r)
        let gScanner:Scanner = Scanner.localizedScanner(with: gString) as! Scanner
        gScanner.scanHexInt32(&g)
        let bScanner:Scanner = Scanner.localizedScanner(with: bString) as! Scanner
        bScanner.scanHexInt32(&b)
        
        let color = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        
        // 加入缓存
        colorUtils.colorsDict[hexColor] = color
        
        return color
    }
    
    class func colorWithHex(hexColor : NSInteger) -> UIColor {
        // 先从缓存中取
        let hexString = String(format: "%ld", hexColor)
        let colorUtils = CMColorUtils.sharedInstance
        if colorUtils.colorsDict[hexString] != nil {
            let color: UIColor = colorUtils.colorsDict[hexString]!
            return color
        }
        
        let color = UIColor(red: CGFloat((hexColor & 0xFF0000) >> 16)/255.0, green: CGFloat((hexColor & 0xFF00) >> 8)/255.0, blue: CGFloat(hexColor & 0xFF)/255.0, alpha: 1.0)
        
        // 加入缓存
        colorUtils.colorsDict[hexString] = color
        
        return color
    }
}
