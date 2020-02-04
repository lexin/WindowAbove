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
    }

    @IBAction func btnOpenClick(_ sender: Any) {
         let ad: ADViewModel = ADViewModel(params: "button click", "bottom", "p3", "p4", "p5",callbackOpen: {
            print ("opened")
        }) {  (val1, val2, val3) in
            print ("closed")
            print (val1)
            print (val2)
            print (val3)
        }
        //ADPresenter.shared.initADEachTime = false // if false - don't reload page each time
        ADPresenter.shared.showAD(viewModel: ad)

    }


}

