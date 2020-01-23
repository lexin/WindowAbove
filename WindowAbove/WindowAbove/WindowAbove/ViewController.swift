//
//  ViewController.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 23.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var coveringWindow: UIWindow?

       func coverEverything() {
        coveringWindow = UIWindow(frame: UIScreen.main.bounds)

           if let coveringWindow = coveringWindow {
            coveringWindow.backgroundColor = UIColor.red
            coveringWindow.windowLevel = UIWindow.Level.alert + 1
               coveringWindow.isHidden = false
            let adVC: ADViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ADViewController") as! ADViewController

            coveringWindow.rootViewController = adVC
           }
       }

    override func viewDidLoad() {
        super.viewDidLoad()
     	coverEverything()
    }


}

