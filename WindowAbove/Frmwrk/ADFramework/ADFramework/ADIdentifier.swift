//
//  ADIdentifier.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 31.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit
import AdSupport

class ADIdentifier: NSObject {

    public static var shared: ADIdentifier = {
        let instance = ADIdentifier()
        return instance
    }()

    override private init() {
        super.init()
    }


    func identifierForAdvertising() -> String? {

        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            return nil
        }

        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }

}
