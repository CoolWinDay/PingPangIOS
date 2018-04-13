//
//  main.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(CMApplication.self),
    NSStringFromClass(AppDelegate.self)
)
