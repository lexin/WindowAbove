//
//  ViewController.swift
//  TestFrmwrk
//
//  Created by Alexey Romanko on 04.02.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit
import ADFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          let deadlineTime = DispatchTime.now() + .milliseconds(250)
              DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                   let ad: ADViewModel = ADViewModel(params: "app foreground iOS 13", "bottom", "p3", "p4", "p5",callbackOpen: {
                  }) {  (val1, val2, val3) in

                  }
                  //ADPresenter.shared.initADEachTime = false // if false - don't reload page each time
                  ADPresenter.shared.showAD(viewModel: ad)
              }
    }


}

