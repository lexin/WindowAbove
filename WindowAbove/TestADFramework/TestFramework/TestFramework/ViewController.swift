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

        let ad: ADViewModel = ADViewModel(param1: "test 1", param2: "bottom", param3: "r1", param4: "r2", param5: "r3", callbackOpen: {
                  print ("opened")
              }) {  (val1, val2, val3) in
                  print ("closed")
                  print (val1)
                  print (val2)
                  print (val3)
              }

        let deadlineTime = DispatchTime.now() + .milliseconds(250)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            ADPresenter.shared.showAD(viewModel: ad)

        }
    }


}

