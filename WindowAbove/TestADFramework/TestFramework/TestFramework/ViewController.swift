//
//  ViewController.swift
//  TestFramework
//
//  Created by Alexey Romanko on 27.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit
import ADFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let deadlineTime = DispatchTime.now() + .milliseconds(250)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            ADPresenter.shared.showAD()

        }
    }


}

