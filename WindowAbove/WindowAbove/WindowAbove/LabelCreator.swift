//
//  LabelCreator.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 03.02.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

class LabelCreator: NSObject {

    class func createSimpleLabel(text: String) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = UIColor.Gray.halfAlpha
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = text
        label.textAlignment = .center
        return label
    }

}
