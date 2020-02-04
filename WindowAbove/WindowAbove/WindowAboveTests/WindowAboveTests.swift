//
//  WindowAboveTests.swift
//  WindowAboveTests
//
//  Created by Alexey Romanko on 03.02.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import XCTest

class WindowAboveTests: XCTestCase {

    let p1 = "unittest"
    let p2 = "bottom"
    let p3 = "test_p3"
    let p4 = "test_p4"
    let p5 = "test_p5"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParams() {
        let expectation = self.expectation(description: "testParams")

        let adViewModel: ADViewModel = ADViewModel(params: p1, p2, p3, p4, p5,callbackOpen: {
            ADPresenter.shared.hideAD()
        }) {  (val1, val2, val3) in
            XCTAssertEqual(val1, self.p3) //callback params
            XCTAssertEqual(val2, self.p4)
            XCTAssertEqual(val3, self.p5)

            expectation.fulfill()
        }

        XCTAssertEqual(adViewModel.topParam(), p1)
        XCTAssertEqual(adViewModel.bottomParam(), p2)

        XCTAssertEqual(adViewModel.param(index: 2), p3)
        XCTAssertEqual(adViewModel.param(index: 3), p4)
        XCTAssertEqual(adViewModel.param(index: 4), p5)

        ADPresenter.shared.showAD(viewModel: adViewModel)
        waitForExpectations(timeout: 30)
    }

    func testCallbacks() {
        let expectation = self.expectation(description: "testParams")
        var testValue = "0"
        let callBackOpen: ()->() = {
            XCTAssertEqual(testValue, "0")
			testValue = "1"
            ADPresenter.shared.hideAD()
        }
        let callBackClose: (String, String, String)->() = {_,_,_ in
            XCTAssertEqual(testValue, "1")
            testValue = "2"
            expectation.fulfill()
        }

        let adViewModel: ADViewModel = ADViewModel(params: p1, p2, p3, p4, p5,callbackOpen: callBackOpen,  callbackClose: callBackClose)

        ADPresenter.shared.showAD(viewModel: adViewModel)
        waitForExpectations(timeout: 30)
       }

    func testSingleTonePresenter () {
        let presenterA = ADPresenter.shared
        let presenterB = ADPresenter.shared
        XCTAssertEqual(presenterA, presenterB)
    }

    func testSingleToneADIdentifier () {
        let adIdentifierA = ADIdentifier.shared
        let adIdentifierB = ADIdentifier.shared
        XCTAssertEqual(adIdentifierA, adIdentifierB)
    }

    func testADIdentifierValue () {
        let adIdentifierA = ADIdentifier.shared
        let adIdentifierB = ADIdentifier.shared
        XCTAssertEqual(adIdentifierA.identifierForAdvertising(), adIdentifierB.identifierForAdvertising())
    }

    func testTimeOut() {
        let expectation = self.expectation(description: "testParams")

        let adViewModel: ADViewModel = ADViewModel(params: "", "",  "",  "",  "", callbackOpen: {
            ADPresenter.shared.hideAD()

        }) {  (val1, val2, val3) in

            expectation.fulfill()
        }
        
        ADPresenter.shared.showAD(viewModel: adViewModel)
        waitForExpectations(timeout: 30) //30 sec
    }


    func testLabelCreator() {
        let testText = "testText"
        let lbl = LabelCreator.createSimpleLabel(text: testText)
        XCTAssertNotNil(lbl)
        XCTAssertEqual(lbl.text ?? "", testText)
    }

    func testOrientationChanges() {
        XCUIDevice.shared.orientation = .portrait

        var firstVC: UIViewController? = nil
        var secondVC: UIViewController? = nil
        let expectation = self.expectation(description: "testParams")
               var testValue = 0
               let callBackOpen: ()->() = {
                   testValue += 1

                if (testValue == 1) {
                    firstVC = ADPresenter.shared.adVC //rememer the layer object for the first time
                }

                XCUIDevice.shared.orientation = .landscapeLeft

                if (testValue==2) { // the lib was triggered by orientation chaging
                    secondVC = ADPresenter.shared.adVC //rememer the layer object for the second time
                    XCTAssertNotEqual(firstVC, secondVC) 	//different view controller due to rule:
                    										//When the library is initialized multiple times, it should remove the old overlay that might
                                                            //exist from a prior initialization and create a new one.
                    expectation.fulfill()

                }
               }
               let callBackClose: (String, String, String)->() = {_,_,_ in
               }

               let adViewModel: ADViewModel = ADViewModel(params: p1, p2, p3, p4, p5,callbackOpen: callBackOpen,  callbackClose: callBackClose)

               ADPresenter.shared.showAD(viewModel: adViewModel)
               waitForExpectations(timeout: 50)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
