//
//  ADPresenter.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 27.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

public class ADPresenter: NSObject {
    public static var shared: ADPresenter = {
        let instance = ADPresenter()

        return instance
    }()


    override private init() {
        super.init()
        print ("self \(self)")
    }

    public func testPublicAD() {
        print("testPublicAD")
    }

    public func showAD(viewModel: ADViewModel) {
        coverEverything(viewModel: viewModel)

        let deadlineTime = DispatchTime.now() + .milliseconds(14250)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.hideAD()
        }

    }
    

    public func hideAD() {
        self.adVC?.close {
        	self.coveringWindow?.isHidden = true
        }

    }

    var coveringWindow: UIWindow?
    var adVC: ADmanualViewController?

    func coverEverything(viewModel: ADViewModel) {
        if (coveringWindow==nil) {
            if #available(iOS 13.0, *) {
                let windowScene = UIApplication.shared
                    .connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .first
                if let windowScene = windowScene as? UIWindowScene {
                    if (coveringWindow==nil) {
                        coveringWindow = UIWindow(windowScene: windowScene)
                    }
                }
            } else  { //older than ios 13
                coveringWindow = UIWindow(frame: UIScreen.main.bounds)
            }

            if let coveringWindow = coveringWindow {
                coveringWindow.frame = UIScreen.main.bounds
                coveringWindow.backgroundColor = UIColor.clear
                coveringWindow.windowLevel = UIWindow.Level.alert + 1
                coveringWindow.isHidden = false
                coveringWindow.makeKeyAndVisible()
                adVC = ADmanualViewController(viewModel: viewModel)
                coveringWindow.rootViewController = adVC

            } else {
                //something wrong with window creation
            }
        } else {
            adVC = ADmanualViewController(viewModel: viewModel)
             if let coveringWindow = coveringWindow {
            	coveringWindow.rootViewController = adVC
            	coveringWindow.isHidden = false
            }
        }
        adVC?.btnCloseClicked = {
            self.hideAD()
        }

    }
}

extension ADPresenter: NSCopying {

    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
