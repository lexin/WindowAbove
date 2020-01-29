//
//  ViewController.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 23.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   

    override func viewDidLoad() {
        super.viewDidLoad()
        let deadlineTime = DispatchTime.now() + .milliseconds(250)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.btnOpenClick(self)
        }

    }
    
    @IBAction func btnOpenClick(_ sender: Any) {
        let ad: ADViewModel = ADViewModel(param1: "top", param2: "bottom", param3: "r1", param4: "r2", param5: "r3", callbackOpen: {
            print ("opened")
        }) {  (val1, val2, val3) in
            print ("closed")
            print (val1)
            print (val2)
            print (val3)
        }
        ADPresenter.shared.showAD(viewModel: ad)
        
    }
    
}

