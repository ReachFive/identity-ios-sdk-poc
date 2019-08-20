import UIKit
import IdentitySdkCore

class SignupController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.reachfive().initialize().onComplete { _ in }
    }

    @IBAction func signup(_ sender: Any) {
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        let name = nameInput.text ?? ""

        let customFields: [String: CustomField] = [
            "test_string": .string("some random string"),
            "test_integer": .int(1)
        ]
        
        let profile = ProfileSignupRequest(
            password: password,
            email: email,
            name: name,
            customFields: customFields
        )
        AppDelegate.reachfive().signup(profile: profile).onSuccess(callback: goToProfile)
    }
    
    func goToProfile(_ authToken: AuthToken) {
        AppDelegate.reachfive().storage.save(key: "AUTH_TOKEN", value: authToken)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileController = storyBoard.instantiateViewController(
            withIdentifier: "ProfileScene"
        ) as! ProfileController
        profileController.authToken = authToken
        self.self.navigationController?.pushViewController(profileController, animated: true)
    }
}
