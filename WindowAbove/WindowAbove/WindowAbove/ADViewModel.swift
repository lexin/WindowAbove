//
//  ADViewModel.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 27.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

typealias CallbackCloseType = (_ p3: String, _ p4: String, _ p5: String) -> ()
typealias CallbackOpenType = () -> ()
public class ADViewModel: NSObject {
    let param1 : String //top label
    let param2 : String //bottom lable
    let param3 : String //returned value
    let param4 : String //returned value
    let param5 : String //returned value

    let callbackClose : CallbackCloseType
    let callbackOpen : CallbackOpenType

    init(param1: String, param2: String, param3: String, param4: String, param5: String, callbackOpen: @escaping CallbackOpenType,  callbackClose : @escaping CallbackCloseType) {
        self.param1 = param1
        self.param2 = param2
        self.param3 = param3
        self.param4 = param4
        self.param5 = param5
        self.callbackClose = callbackClose
        self.callbackOpen = callbackOpen
    }
}
