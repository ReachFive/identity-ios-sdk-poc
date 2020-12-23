//
//  SignupWithEmailSuccess.swift
//  SandboxUITests
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 Reachfive. All rights reserved.
//

import XCTest

class SignupWithEmailSuccess: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignupWithEmail() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var uuid = UUID().uuidString
        uuid += "@testaccount.io"
        
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Signup with password"]/*[[".cells.staticTexts[\"Signup with password\"]",".staticTexts[\"Signup with password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailTextField = app.textFields["email"]
                      let passwordTextField = app.textFields["password"]
                      
                      emailTextField.tap()
                      emailTextField.typeText(uuid)
                      sleep(1)
                      passwordTextField.tap()
                      passwordTextField.typeText("Test1806@")
                      
                      let loginButton = app.buttons["signup"]
                      loginButton.tap()
                      
                      sleep(1)
                      let updateEmail = app.buttons["email"]
                      XCTAssert(updateEmail.exists)
    }

   
}
