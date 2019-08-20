import UIKit
import Foundation
import IdentitySdkCore

class UpdatePasswordController: UIViewController {
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!

    @IBAction func update(_ sender: Any) {
        AppDelegate.reachfive()
            .updatePassword(updatePasswordParams: .AccessTokenParams(password: newPassword.text ?? "", oldPassword: oldPassword.text ?? ""))
            .onComplete { result in
                print("startPasswordless email \(result)")
        }
    }
}
