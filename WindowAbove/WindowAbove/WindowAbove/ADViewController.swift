//
//  ADViewController.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 23.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {

    @IBOutlet weak var webViewCenter: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        self.view.window?.windowLevel = UIWindow.Level.normal - 1;
    }

    @IBAction func btnShowWebClick(_ sender: Any) {
        moveWebViewCenter(value: 0)
    }

    @IBAction func btnHideWebClick(_ sender: Any) {
        moveWebViewCenter(value: self.view.frame.size.width)
    }

    func moveWebViewCenter(value: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.webViewCenter.constant = value
            self.view.layoutIfNeeded()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
