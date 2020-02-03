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

    private let params: [String]

    let callbackClose : CallbackCloseType
    let callbackOpen : CallbackOpenType

    public init(params: String..., callbackOpen: @escaping CallbackOpenType,  callbackClose : @escaping CallbackCloseType) {
        self.params = params

        self.callbackClose = callbackClose
        self.callbackOpen = callbackOpen
    }

    func param(index: Int) -> String? {
        if (self.params.count > index) {
            return self.params[index]
        }
        return nil
    }

    func topParam() -> String? {
        return param(index: 0)
    }

    func bottomParam() -> String? {
        return param(index: 1)
    }
    

}
