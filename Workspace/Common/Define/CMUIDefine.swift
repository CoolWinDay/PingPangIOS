//
//  UIUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/14.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

// screen
extension UIScreen {
    class func ScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func ScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}

// color
extension UIColor {
    // bg
    class func ColorBgTheme() -> UIColor {
        return self.hexColor(hexInteger: 0xDC3237)
    }
    class func ColorBgNormal() -> UIColor {
        return UIColor.white
    }
    class func ColorBgGray() -> UIColor {
        return self.hexColor(hexInteger: 0xbbbbbb)
    }
    
    // text
    class func ColorTextTheme() -> UIColor {
        return self.hexColor(hexInteger: 0xCC4051)
    }
    class func ColorTextDeep() -> UIColor {
        return UIColor.black
    }
    class func ColorTextNormal() -> UIColor {
        return self.hexColor(hexInteger: 0x423631)
    }
    class func ColorTextLight() -> UIColor {
        return self.hexColor(hexInteger: 0x037aff)
    }
    class func ColorTextGray() -> UIColor {
        return self.hexColor(hexInteger: 0x999999)
    }
    class func ColorTextWhite() -> UIColor {
        return UIColor.white
    }
    
    // line
    class func ColorLine() -> UIColor {
        return self.hexColor(hexInteger: 0xe5e5e5)
    }
    class func ColorLineDeep() -> UIColor {
        return self.hexColor(hexInteger: 0x999999)
    }
}

// font
extension UIFont {
    class func FontNormal() -> UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    class func FontMid() -> UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    class func FontSmall() -> UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
}
