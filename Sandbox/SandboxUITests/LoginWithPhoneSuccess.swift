import XCTest

class LoginWithPhoneSuccess: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testLoginWithPhone() throws {
        
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
        let predicate = NSPredicate(format: "label BEGINSWITH 'Email: '")
        let element = app.staticTexts.element(matching: predicate)
        XCTAssert(element.exists)
        
        
    }
}
