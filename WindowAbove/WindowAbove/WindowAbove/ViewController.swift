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
            ADPresenter.shared.showAD()
          
        }

    }

    @IBAction func btnOpenClick(_ sender: Any) {
        ADPresenter.shared.showAD()
    }

}

