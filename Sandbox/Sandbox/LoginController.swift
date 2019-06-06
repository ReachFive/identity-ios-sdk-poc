import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        print("Login email=\(email) password=\(password)")
        AppDelegate.shared().reachfive.loginWithPassword(username: email, password: password, success: { print($0) }, failure: { print($0) })
    }
    
}
