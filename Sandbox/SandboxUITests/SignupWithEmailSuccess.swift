import XCTest

class SignupWithEmailSuccess: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testSignupWithEmail() throws {
       
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
        let emailLabel = app.staticTexts["email"]
        XCTAssertEqual("Email: "+uuid.lowercased(), emailLabel.label)
    }
}
