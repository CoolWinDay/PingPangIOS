//
//  CMStringUtils.swift
//  CommonSwift
//
//  Created by 张艳清 on 17/2/27.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

extension String {
    
    // string转number
    func safeIntegerValue() -> NSNumber {
        let formatter = NumberFormatter()
        if formatter.number(from: self) == nil {
            return 0
        }
        return formatter.number(from: self)!
    }
    
    // 去掉前后空格
    func trimSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    // 是否包含表情符(表情列表要及时更新)
    func isContainsEmoji() -> Bool {
        // 不准确，其中包含了（。、）等
        for scalar in unicodeScalars {
            switch scalar.value {
            case
                0x00A0...0x00AF,
                0x2030...0x204F,
                0x2120...0x213F,
                0x2190...0x21AF,
                0x2310...0x329F,
                0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false

//        var returnValue = false
//        self.enumerateSubstrings(in: self.startIndex..<self.endIndex, options: .byComposedCharacterSequences) { (theString, substringRange, enclosingRange, stop) in
//            let substring = theString! as NSString
//            let hs: unichar = substring.character(at: 0)
//            if (0xd800 <= hs && hs <= 0xdbff) {
//                if (substring.length > 1) {
//                    let ls: unichar = substring.character(at: 1)
//                    let aaa = ((hs - 0xd800) * 0x400) + (ls - 0xdc00)
//                    let uc: Int16 = ((hs - 0xd800) * 0x400) + (ls - 0xdc00)
//                    if (0x1d000 <= uc && uc <= 0x1f77f) {
//                        returnValue = true;
//                    }
//                }
//            }
//        }
//        
//        return returnValue
    }
    
    func stringWithoutEmoji() -> String {
        var array = [Int]()
        var i = 0
        for scalar in unicodeScalars {
            switch scalar.value {
            case
                0x00A0...0x00AF,
                0x2030...0x204F,
                0x2120...0x213F,
                0x2190...0x21AF,
                0x2310...0x329F,
                0x1F000...0x1F9CF:
                array.append(i)
            default:
                print(i)
            }
            i += 1
        }
        
        var result: String = String(stringLiteral: self)
        for index in array {
            result.remove(at: self.index(self.startIndex, offsetBy: index))
        }
        return result
    }
    
    // 是否整形
    func isIntNumber() -> Bool {
        let rule = "^-?\\d+$"
        let pred = NSPredicate(format:"SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 是否浮点型
    func isFloatNumber() -> Bool {
        let rule = "^(-?\\d+)(\\.\\d+)?$"
        let pred = NSPredicate(format:"SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 纯数字
    func isNumber() -> Bool {
        let rule = "^[0-9]+$"
        let pred = NSPredicate(format:"SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 纯字母
    func isLetter() -> Bool {
        let rule = "^[A-Za-z]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 字母或数字：
    func isNumberOrLetter() -> Bool {
        let rule = "^[A-Za-z0-9]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 纯汉字
    func isChiness() -> Bool {
        let rule = "[\u{4e00}-\u{9fa5}]+$"
        let pred = NSPredicate(format:"SELF MATCHES %@",rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 手机号
    func isPhoneNumber() -> Bool {
        let rule = "^0{0,1}(13[0-9]|15[3-9]|15[0-2]|18[0-9]|17[5-8]|14[0-9]|170|171|173)[0-9]{8}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    // 身份证
    func isIdentityCard() -> Bool {
        let rule = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let pred = NSPredicate(format: "SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }

    // 邮箱地址
    func isEmail() -> Bool {
        let rule = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pred = NSPredicate(format:"SELF MATCHES %@", rule)
        let isMatch = pred.evaluate(with: self)
        return  isMatch
    }
    
    static func random() -> String {
        let identifier = CFUUIDCreate(nil)
        let identifierString = CFUUIDCreateString(nil, identifier) as String
        let cStr = identifierString.cString(using: .utf8)
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(cStr, CC_LONG(strlen(cStr)), &digest)
        
        var output = String()
        for i in digest {
            output = output.appendingFormat("%02X", i)
        }
        
        return output;
    }
    
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }

}

