import UIKit
import IdentitySdkCore

class SignupController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.reachfive().initialize()
    }

    @IBAction func signup(_ sender: Any) {
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        let name = nameInput.text ?? ""

        print("Signup email=\(email) password=\(password) name=\(name)")

        let profile = Profile(email: email, password: password)
        AppDelegate.reachfive().signupWithPassword(profile: profile, callback: { print($0) })
    }
}
