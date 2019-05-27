import UIKit
import IdentitySdkCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = WebViewProvider()
        
        let sdkConfig = SdkConfig(domain: "local-sandbox.og4.me", clientId: "sg48CdAYohRPeRWZ9j1H")
        
        print(provider.create(sdkConfig: sdkConfig).helloWorld())
        // Do any additional setup after loading the view.
    }

}
