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
        let facebookProvider = app.tables/*@START_MENU_TOKEN@*/.staticTexts["facebook"]/*[[".cells.staticTexts[\"facebook\"]",".staticTexts[\"facebook\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(facebookProvider.exists)
        facebookProvider.tap()
        let webViewsQuery = app.webViews
        let mobileNumberOrEmailTextField = webViewsQuery/*@START_MENU_TOKEN@*/.textFields["Mobile number or email"]/*[[".otherElements[\"Log into Facebook | Facebook\"]",".otherElements[\"main\"].textFields[\"Mobile number or email\"]",".textFields[\"Mobile number or email\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: mobileNumberOrEmailTextField, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        mobileNumberOrEmailTextField.tap()
        mobileNumberOrEmailTextField.typeText("myemail@gmail.com")
        let passwordTextField = webViewsQuery/*@START_MENU_TOKEN@*/.secureTextFields["Facebook Password"]/*[[".otherElements[\"Log into Facebook | Facebook\"]",".otherElements[\"main\"].secureTextFields[\"Facebook Password\"]",".secureTextFields[\"Facebook Password\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("password")
        let loginButton = webViewsQuery.buttons["Log In"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        let errorMessage = webViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["The password you entered is incorrect."]/*[[".otherElements[\"Log into Facebook | Facebook\"]",".otherElements[\"main\"].staticTexts[\"The password you entered is incorrect.\"]",".staticTexts[\"The password you entered is incorrect.\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: errorMessage, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
    }

}
