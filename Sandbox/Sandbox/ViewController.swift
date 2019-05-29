import UIKit
import IdentitySdkCore
import IdentitySdkFacebook

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let provider = WebViewProvider()
        let facebook = FacebookProvider()
        
        let sdkConfig = SdkConfig(domain: "local-sandbox.og4.me", clientId: "sg48CdAYohRPeRWZ9j1H")
        let reachfive = ReachFive(sdkConfig: sdkConfig, providersCreators: [facebook, provider])
        
        reachfive.show()
    }

}
