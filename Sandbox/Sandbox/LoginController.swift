import UIKit
import IdentitySdkCore

class LoginController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var providers: [Provider] = []
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var providersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        providersTableView.dataSource = self
        providersTableView.delegate = self
        
        AppDelegate.reachfive().initialize(success: {
            self.providers.append(contentsOf: $0)
            self.providersTableView.reloadData()
        }, failure: {
            print("initialize error \($0)")
        })
    }
    
    public func reloadProvidersData(providers: [Provider]) {
        self.providers = providers
        self.providersTableView.reloadData()
    }
    
    @IBAction func login(_ sender: Any) {
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        print("Login email=\(email) password=\(password)")
        AppDelegate.shared().reachfive.loginWithPassword(username: email, password: password, success: { print($0) }, failure: { print($0) })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "providerCell")
        
        let provider = providers[indexPath.row]
        
        cell?.textLabel?.text = provider.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedProvider = providers[indexPath.row]
        
        print("Select \(selectedProvider.name)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
