import XCTest

extension ClosedRange where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}

class SignupLoginSuccess: XCTestCase {
    
    var uuid = UUID().uuidString
    let rndPswd = "P@ssw0rd"
    var newPhoneNumber = String()
    
    override func setUpWithError() throws {
        
        uuid += "@testaccount.io"
        newPhoneNumber = randomPhoneNumber()
        continueAfterFailure = false
        
    }
    
    override func tearDownWithError() throws {
    }
    
    func testSignupLogin() throws {
        
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tables.staticTexts["Signup with password"].tap()
        
        // Test Signup with email
        let emailTextField = app.textFields["email"]
        let passwordTextField = app.textFields["password"]
        
        emailTextField.tap()
        emailTextField.typeText(uuid)
        sleep(1)
        passwordTextField.tap()
        passwordTextField.typeText(rndPswd)
        
        let loginButton = app.buttons["signup"]
        loginButton.tap()
        
        sleep(1)
        let emailLabel = app.staticTexts["email"]
        XCTAssertEqual("Email: "+uuid.lowercased(), emailLabel.label)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Test login with email
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Login with password"]/*[[".cells.staticTexts[\"Login with password\"]",".staticTexts[\"Login with password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailTextFieldLogin = app.textFields["login"]
        let passwordTextFieldLogin = app.textFields["password"]
        
        emailTextFieldLogin.tap()
        emailTextFieldLogin.typeText(uuid)
        sleep(1)
        passwordTextFieldLogin.tap()
        passwordTextFieldLogin.typeText(rndPswd)
        
        let loginButtonLogin = app.buttons["login"]
        loginButtonLogin.tap()
        sleep(2)
        
        let emailLabelLogin = app.staticTexts["email"]
        XCTAssertEqual("Email: "+uuid.lowercased(), emailLabelLogin.label)
        
        //signup with phone number
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCUIApplication().tables.staticTexts["Signup with password"].tap()
        let phoneTextField = app.textFields["phone"]
        phoneTextField.tap()
        phoneTextField.typeText(newPhoneNumber)
        
        sleep(1)
        passwordTextFieldLogin.tap()
        passwordTextFieldLogin.typeText(rndPswd)
        loginButton.tap()
        
        sleep(1)
        let phoneLabel = app.staticTexts["phone"]
        XCTAssertEqual("Phone: +33"+newPhoneNumber, phoneLabel.label)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // login with phone number        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Login with password"]/*[[".cells.staticTexts[\"Login with password\"]",".staticTexts[\"Login with password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextFieldLogin.tap()
        emailTextFieldLogin.typeText(newPhoneNumber)
        sleep(1)
        passwordTextFieldLogin.tap()
        passwordTextFieldLogin.typeText(rndPswd)
        
        loginButtonLogin.tap()
        XCTAssertEqual("Phone: +33"+newPhoneNumber, phoneLabel.label)
    }
    
    func randomPhoneNumber() -> String {
        let min: UInt32 = 100_000_00
        let max: UInt32 = 999_999_99
        let i = min + arc4random_uniform(max - min + 1)
        return  String((1...9).random(without: [40,50,60]) ) + String(i)
    }
}
