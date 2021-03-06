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
    var topLabel: UILabel? 		= nil
    var midLabel: UILabel?      = nil
    var bottomLabel: UILabel? 	= nil
    var centerView: UIView? 	= nil
    var btnClose: UIButton? 	= nil

    var hiddenContentCenter : CGPoint = CGPoint(x: 0, y: 0)
    var shownContentCenter : CGPoint = CGPoint(x: 0, y: 0)
    var viewModel: ADViewModel?
    var alreadyLoaded = false

    var isADVisibleNow = false

    var statusBarFrameP : CGFloat? = nil
    var statusBarFrameL : CGFloat? = nil

    var btnCloseClicked: (()->())? = nil
    var adShouldBeReInit: (()->())? = nil
    var adIsLoaded: (()->())? = nil

    var currentOrientation : UIDeviceOrientation? = nil


    //MARK: life
    //MARK: -
    init(viewModel: ADViewModel, adID: String) {
        super.init(nibName: nil, bundle: nil)

        detectStatusBarHeight()

        self.viewModel = viewModel
        self.view.backgroundColor = UIColor.clear

        // container view
        self.centerView = UIView(frame: CGRect.zero)
        centerView!.backgroundColor = UIColor.clear
        self.view.addSubview(centerView!)
        //

        // webView
        self.webView = WKWebView(frame: CGRect.zero);
        self.webView?.navigationDelegate = self
        centerView!.addSubview(webView!)
        self.load()
        //

        // set of labels --
        self.topLabel = LabelCreator.createSimpleLabel(text: viewModel.topParam() ?? "")
		webView!.addSubview(topLabel!)

        self.midLabel = LabelCreator.createSimpleLabel(text: adID)
        webView!.addSubview(midLabel!)

        self.bottomLabel = LabelCreator.createSimpleLabel(text: viewModel.bottomParam() ?? "")
        bottomLabel!.backgroundColor = UIColor.lightGray
        webView!.addSubview(bottomLabel!)
        //

        // close button
        self.btnClose = UIButton(frame: CGRect.zero)
        btnClose!.setTitle("X", for: .normal)
        btnClose!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btnClose!.backgroundColor = UIColor.Gray.halfAlpha
        btnClose!.layer.cornerRadius = 15
        webView!.addSubview(btnClose!)
        //

        self.currentOrientation = UIDevice.current.orientation
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (statusBarFrameP == nil) || ( statusBarFrameL == nil) {
            detectStatusBarHeight()
            setProperFrames(mainSize: self.view.frame.size)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let currentOrientation = self.currentOrientation {
            if (currentOrientation != UIDevice.current.orientation) {
                adShouldBeReInit?()
            }
        } else {
            self.currentOrientation = UIDevice.current.orientation
        }
        setProperFrames(mainSize:size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -

    @objc func buttonAction(sender: UIButton!) {
        btnCloseClicked?()
    }

    func setProperFrames(mainSize: CGSize) {
        let tx: CGFloat = 0
        let ty: CGFloat = UIDevice.current.orientation.isLandscape ?  (statusBarFrameL ?? 0) : (statusBarFrameP  ?? 0)
        let w = mainSize.width - tx*2
        let h = mainSize.height - ty

        centerView!.frame = CGRect(x: tx, y: ty, width: w, height: h)
        self.webView?.frame = centerView!.bounds

        let hLabel: CGFloat = 30
        let wLabel: CGFloat = mainSize.width

        topLabel?.frame =  CGRect(x: 0, y: 0, width: wLabel, height: hLabel)

        let webHeight: CGFloat = webView?.frame.size.height ?? 100;
        bottomLabel?.frame = CGRect(x: 0, y: webHeight-hLabel*2, width: wLabel, height: hLabel*2)

        let midY  = webHeight / 2.0;
        midLabel?.frame = CGRect(x: 0, y: midY - hLabel, width: wLabel, height: hLabel*2)

        hiddenContentCenter = CGPoint(x: mainSize.width + mainSize.width/2.0, y: webView!.center.y) // set the right side position
        shownContentCenter = CGPoint(x: mainSize.width/2.0, y:self.webView!.center.y ) // center of the view

        if (isADVisibleNow) {
            self.webView?.center = shownContentCenter
        } else {
            self.webView?.center = hiddenContentCenter
        }

        btnClose!.frame = CGRect(x: 10, y: 35, width: 30, height: 30)
    }

    func detectStatusBarHeight() {
        if UIDevice.current.orientation.isLandscape {
            statusBarFrameL = StatusBarManager.height()
        } else {
            statusBarFrameP = StatusBarManager.height()
        }
    }

    func load() {
        let request = URLRequest(url: URL(string: "https://www.pollfish.com")!)
        webView?.load(request)
    }

    func show(ended:@escaping ()->() ) {
        if (self.alreadyLoaded) {
            adIsLoaded? ()
            let deadlineTime = DispatchTime.now() + .milliseconds(10)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                UIView.animate(withDuration: 0.25, animations: {
                    self.webView!.center = self.shownContentCenter
                },
                               completion: { (_) in
                                self.isADVisibleNow = true
                                if let vm = self.viewModel {
                                    vm.callbackOpen()
                                    ended()
                                }
                })

            }
        } else {
            load()
        }
    }

    func close(ended:@escaping ()->() ) {
        UIView.animate(withDuration: 0.25, animations: {
            self.webView!.center = self.hiddenContentCenter
        },
                       completion: { (_) in
                        self.isADVisibleNow = false
                        if let vm = self.viewModel {

                            vm.callbackClose(vm.param(index: 2) ?? "",
                                             vm.param(index: 3) ?? "",
                                             vm.param(index: 4) ?? "")
                            ended()
                        }
        })
    }


    //MARK: webView delegate
    //MARK: -
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
        alreadyLoaded = true

        self.show {

        }

    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        adIsLoaded? ()
        print ("webView didFail \(error.localizedDescription)")
    }

}
