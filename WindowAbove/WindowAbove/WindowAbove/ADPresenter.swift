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


    public var initADEachTime: Bool = true

    var viewModel : ADViewModel? = nil
    var alreadyStartedProcess = false

    override private init() {
        super.init()
    }
    
    public func showAD(viewModel: ADViewModel) {
        if (alreadyStartedProcess == false) {
            alreadyStartedProcess = true
            self.viewModel = viewModel
            coverEverything(viewModel: viewModel)
        } else {
            print("the process is already start")
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

        guard let adID = ADIdentifier.shared.identifierForAdvertising() else {
            return
        }
        
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

                coveringWindow.makeKeyAndVisible()
                adVC = ADmanualViewController(viewModel: viewModel, adID: adID)
                coveringWindow.rootViewController = adVC
                coveringWindow.isHidden = true

            } else {
                //something wrong with window creation
            }
        } else {

            if ( (adVC == nil) || (self.initADEachTime) ) {
                adVC = ADmanualViewController(viewModel: viewModel, adID: adID)
                coveringWindow?.isHidden = true
            } else {
                adVC?.show {}
            }
            if let coveringWindow = coveringWindow {
                coveringWindow.rootViewController = adVC
            }
        }
        adVC?.btnCloseClicked = { //when user touch close button
            self.hideAD()
        }
        adVC?.adIsLoaded = { //when content is loaded
            self.alreadyStartedProcess = false
            self.coveringWindow?.isHidden = false
        }
        adVC?.adShouldBeReInit = { //when lib triggers reinit
            if let viewModel = self.viewModel {
                self.coverEverything(viewModel: viewModel)
            }
        }
    }
}

extension ADPresenter: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
