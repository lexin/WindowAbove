//
//  WindowAboveUITests.swift
//  WindowAboveUITests
//
//  Created by Alexey Romanko on 04.02.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import XCTest

class WindowAboveUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresenting_Hiding() {
        let app = XCUIApplication()
        app.launch()
        sleep(10)
        XCTAssert(app.webViews.count > 0) // there is a webView
    	XCTAssert(app.staticTexts["GET CONNECTED"].exists) //the webpage is already loaded
        app.buttons["X"].tap()
        sleep(2)
    	XCTAssertFalse(app.staticTexts["GET CONNECTED"].exists) //the webpage is already not visible
        XCTAssert(app.webViews.count == 0) //the number of visual WebView is 0
        
    }
    func testOrientationChanges() {
        let app = XCUIApplication()
      	app.launch()
        XCUIDevice.shared.orientation = .portrait
        sleep(10)

        XCUIDevice.shared.orientation = .landscapeLeft // trigger libs reinit
        XCTAssert(app.webViews.count == 0) //the number of visual WebView is 0
        sleep(10)
        XCTAssert(app.webViews.count > 0) // there is a webView
        XCTAssert(app.staticTexts["GET CONNECTED"].exists) //the webpage is already loaded

    }

    func testForegroundChanges() {
    	let app = XCUIApplication()
       	app.launch()
       	sleep(10)

        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)
        let appItem = XCUIApplication(bundleIdentifier: "romanko.WindowAbove")
        appItem.activate()
        
        sleep(1)
        XCTAssert(app.webViews.count == 0) //the number of visual WebView is 0
        sleep(10)
        XCTAssert(app.webViews.count > 0) // there is a webView
        XCTAssert(app.staticTexts["GET CONNECTED"].exists) //the webpage is already loaded
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
