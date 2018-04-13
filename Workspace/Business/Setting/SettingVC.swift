//
//  SettingVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class SettingVC: CMBaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var updateSeg: UISegmentedControl!
    @IBOutlet weak var updateText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // update
        let updateType = UserDefaults.getUserDefaultsString(UserDefaults.UDKey_UpdateType)
        if updateType == UserDefaults.UDValue_UpdateTypeOptional {
            updateSeg.selectedSegmentIndex = 1
        }
        else if updateType == UserDefaults.UDValue_UpdateTypeForce {
            updateSeg.selectedSegmentIndex = 2
        }
        else {
            updateSeg.selectedSegmentIndex = 0
        }
        
        updateText.text = UserDefaults.getUserDefaultsString(UserDefaults.UDKey_UpdateVersion)
    }

    @IBAction
    func updateType(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            UserDefaults.setUserDefaultsString(UserDefaults.UDValue_UpdateTypeNone, forKey: UserDefaults.UDKey_UpdateType)
            break
        case 1:
            UserDefaults.setUserDefaultsString(UserDefaults.UDValue_UpdateTypeOptional, forKey: UserDefaults.UDKey_UpdateType)
            break
        case 2:
            UserDefaults.setUserDefaultsString(UserDefaults.UDValue_UpdateTypeForce, forKey: UserDefaults.UDKey_UpdateType)
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserDefaults.setUserDefaultsString(textField.text?.trimSpace(), forKey: UserDefaults.UDKey_UpdateVersion)
    }
    
}
