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

    public func showAD() {
        if #available(iOS 13.0, *) {
            coverEverything13()
        } else {
            coverEverythingOld()
        }
    }
    

    public func hideAD() {
        //let deadlineTime = DispatchTime.now() + .milliseconds(2500)
          //    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.coveringWindow?.isHidden = true
            //  }
    }

    var coveringWindow: UIWindow?

    func coverEverything13() {
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first

            if let windowScene = windowScene as? UIWindowScene {
                if (coveringWindow==nil) {
                    coveringWindow = UIWindow(windowScene: windowScene)
                    if let coveringWindow = coveringWindow {
                        coveringWindow.frame = UIScreen.main.bounds
                        coveringWindow.backgroundColor = UIColor.clear
                        coveringWindow.windowLevel = UIWindow.Level.alert + 1
                        coveringWindow.isHidden = false
                        coveringWindow.makeKeyAndVisible()
                        let adVC: ADmanualViewController = ADmanualViewController(viewModel: "VM", someDependency: "dep")

                        coveringWindow.rootViewController = adVC
                    }
                } else {
                    coveringWindow?.isHidden = false
                }
            }
        }
    }

    func coverEverythingOld() {
        if (coveringWindow==nil) {
            coveringWindow = UIWindow(frame: UIScreen.main.bounds)

            if let coveringWindow = coveringWindow {
                coveringWindow.backgroundColor = UIColor.clear
                coveringWindow.windowLevel = UIWindow.Level.alert + 1
                coveringWindow.isHidden = false
                let adVC: ADmanualViewController = ADmanualViewController(viewModel: "VM", someDependency: "dep")
                coveringWindow.rootViewController = adVC
            }
        }
        else {
            coveringWindow?.isHidden = false
        }
    }
}

extension ADPresenter: NSCopying {

    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
