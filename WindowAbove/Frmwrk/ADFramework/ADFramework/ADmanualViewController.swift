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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(viewModel: String, someDependency: String) {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = UIColor.clear

        let tx: CGFloat = 0
        let ty: CGFloat = 40
        let w = self.view.frame.size.width - tx*2
        let h = self.view.frame.size.height - ty*2

        let centerView : UIView = UIView(frame: CGRect(x: tx, y: ty, width: w, height: h))
        centerView.backgroundColor = UIColor.clear
        self.view.addSubview(centerView)

        self.webView = WKWebView(frame: centerView.bounds)
        self.webView?.navigationDelegate = self
        centerView.addSubview(webView!)
        let request = URLRequest(url: URL(string: "https://learnappmaking.com")!)
        webView!.load(request)

        webView!.center = CGPoint(x: self.view.frame.size.width + self.view.frame.size.width/2.0, y: webView!.center.y)

        let topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        topLabel.backgroundColor = UIColor.clear
        topLabel.text = "Top label"
        topLabel.textAlignment = .center
        webView!.addSubview(topLabel)

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
        	self.webView!.center = CGPoint(x: self.view.frame.size.width/2.0, y:self.webView!.center.y )
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
