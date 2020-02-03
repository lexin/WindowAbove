//
//  StatusBarManager.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 03.02.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

class StatusBarManager: NSObject {
    class func height() -> CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
 			return UIApplication.shared.statusBarFrame.height
        }
    }

}
