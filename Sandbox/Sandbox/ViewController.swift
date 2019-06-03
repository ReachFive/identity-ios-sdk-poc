import UIKit
import IdentitySdkCore
import IdentitySdkFacebook

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let provider = WebViewProvider()
        let facebook = FacebookProvider()
        
        let sdkConfig = SdkConfig(domain: "integ-guillaume.reach5.net", clientId: "aQKiT49jlrTVKrrLsuDR")
        let reachfive = ReachFive(sdkConfig: sdkConfig, providersCreators: [facebook, provider])
        
        reachfive.initialize()
    }

}
