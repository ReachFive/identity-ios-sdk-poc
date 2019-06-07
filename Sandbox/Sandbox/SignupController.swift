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
        // TODO builder pattern or unordered named parametres
        let profile = Profile(email: email, password: password, phoneNumber: nil, gender: nil, name: name, givenName: nil, middleName: nil, familyName: nil, nickname: nil, username: nil, birthdate: nil, picture: nil, company: nil, locale: nil, address: nil, customFields: nil)
        AppDelegate.reachfive().signupWithPassword(profile: profile, success: { print($0) }, failure: { print($0) })
    }

}
