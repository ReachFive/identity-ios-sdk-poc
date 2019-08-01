import XCTest

class SandboxUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTest() {
        let app = XCUIApplication()
        let facebookProvider = app.tables.staticTexts["facebook"]
        XCTAssertTrue(facebookProvider.exists)
        facebookProvider.tap()
        let webViewsQuery = app.webViews
        let mobileNumberOrEmailTextField = webViewsQuery.textFields["Mobile number or email"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: mobileNumberOrEmailTextField, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        mobileNumberOrEmailTextField.tap()
        mobileNumberOrEmailTextField.typeText("myemail@gmail.com")
        let passwordTextField = webViewsQuery.secureTextFields["Facebook Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("password")
        let loginButton = webViewsQuery.buttons["Log In"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        let errorMessage = webViewsQuery.staticTexts["The password you entered is incorrect."]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: errorMessage, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
    }

}
