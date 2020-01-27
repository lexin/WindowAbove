//
//  ADmanualViewController.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 23.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit
import WebKit

class ADmanualViewController: UIViewController, WKNavigationDelegate {


    var webView: WKWebView?

    var hiddenContentCenter : CGPoint = CGPoint(x: 0, y: 0)
    var shownContentCenter : CGPoint = CGPoint(x: 0, y: 0)
    var viewModel: ADViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(viewModel: ADViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
        self.view.backgroundColor = UIColor.clear

        let tx: CGFloat = 0
        let ty: CGFloat = UIApplication.shared.statusBarFrame.height
        let w = self.view.frame.size.width - tx*2
        let h = self.view.frame.size.height - ty

        let centerView : UIView = UIView(frame: CGRect(x: tx, y: ty, width: w, height: h))
        centerView.backgroundColor = UIColor.clear
        self.view.addSubview(centerView)

        self.webView = WKWebView(frame: centerView.bounds)
        self.webView?.navigationDelegate = self
        centerView.addSubview(webView!)
        let request = URLRequest(url: URL(string: "https://www.pollfish.com")!)
        webView!.load(request)

        hiddenContentCenter = CGPoint(x: self.view.frame.size.width + self.view.frame.size.width/2.0, y: webView!.center.y) // set the right side position
        shownContentCenter = CGPoint(x: self.view.frame.size.width/2.0, y:self.webView!.center.y ) // center of the view

        webView!.center = hiddenContentCenter

        let hLabel = 30
        let wLabel = Int(self.view.frame.size.width)
        let topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: wLabel, height: hLabel))
        topLabel.backgroundColor = UIColor.clear
        topLabel.font = UIFont.boldSystemFont(ofSize: 14)
        topLabel.text = viewModel.param1
        topLabel.textAlignment = .center
        webView!.addSubview(topLabel)

        let bottomLabel: UILabel = UILabel(frame: CGRect(x: 0, y: Int(webView?.frame.size.height ?? 100) - hLabel*2, width: wLabel, height: hLabel*2))
        bottomLabel.backgroundColor = UIColor.lightGray
        bottomLabel.font = UIFont.boldSystemFont(ofSize: 14)
        bottomLabel.text = viewModel.param2
        bottomLabel.textAlignment = .center
        webView!.addSubview(bottomLabel)

    }

    func close(ended:@escaping ()->() ) {
        UIView.animate(withDuration: 0.25, animations: {
            self.webView!.center = self.hiddenContentCenter
        },
            completion: { (_) in
                if let vm = self.viewModel {
                	vm.callback(vm.param3, vm.param4, vm.param5)
                    ended()
                }
        })

    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print ("webView didStartProvisionalNavigation")
    }


    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print ("webView didReceiveServerRedirectForProvisionalNavigation")

    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print ("webView didFailProvisionalNavigation")
    }


    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print ("webView didCommit START")

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print ("webView didFinish END")
        UIView.animate(withDuration: 0.25) {
            self.webView!.center = self.shownContentCenter
        }

    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print ("webView didFail \(error.localizedDescription)")
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
