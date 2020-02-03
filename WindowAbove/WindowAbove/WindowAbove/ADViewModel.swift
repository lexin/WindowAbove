//
//  ADViewModel.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 27.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

public typealias CallbackCloseType = (_ p3: String, _ p4: String, _ p5: String) -> ()
public typealias CallbackOpenType = () -> ()
public class ADViewModel: NSObject {

    let params: [String]

    let callbackClose : CallbackCloseType
    let callbackOpen : CallbackOpenType

//    public init(param1: String, param2: String, param3: String, param4: String, param5: String, callbackOpen: @escaping CallbackOpenType,  callbackClose : @escaping CallbackCloseType) {
    public init(params: String..., callbackOpen: @escaping CallbackOpenType,  callbackClose : @escaping CallbackCloseType) {
        self.params = params

        self.callbackClose = callbackClose
        self.callbackOpen = callbackOpen
    }
}
