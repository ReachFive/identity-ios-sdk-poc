//
//  LoginWithPhoneSuccess.swift
//  SandboxUITests
//
//  Created by admin on 17/12/2020.
//  Copyright © 2020 Reachfive. All rights reserved.
//

import XCTest

class LoginWithPhoneSuccess: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginWithPhone() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.launch()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Login with password"]/*[[".cells.staticTexts[\"Login with password\"]",".staticTexts[\"Login with password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
               
               let emailTextField = app.textFields["login"]
               let passwordTextField = app.textFields["password"]
               
               emailTextField.tap()
               emailTextField.typeText("0605040302")
               sleep(1)
               passwordTextField.tap()
               passwordTextField.typeText("Test1806@")
               
               let loginButton = app.buttons["login"]
               loginButton.tap()
               
               sleep(1)
               let updateEmail = app.buttons["email"]
               XCTAssert(updateEmail.exists)
    }
  

}
