import UIKit
import IdentitySdkCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = WebViewProvider()
        
        print(provider.helloWorld())
        // Do any additional setup after loading the view.
    }

}
