import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    var url_entrar = "http://127.0.0.1/ws/login.php"
    var respuesta = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let sesion = UserDefaults.standard.object(forKey: "sesion") as? String {
            if sesion == "login"{
                performSegue(withIdentifier: "entrar", sender: self)
            }
        }
    }


    
    @IBAction func entrar(_ sender: UIButton) {
        let parametros : Parameters = [
            "usuario": usuario.text!,
            "pass": pass.text!
        ]
        
        Alamofire.request(url_entrar, method: .post, parameters: parametros).responseJSON { (response) in
            print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                self.respuesta = (jsonData.value(forKey: "mensaje") as! String?)!
                
                if self.respuesta == "login completo"{
                    UserDefaults.standard.set("login", forKey: "sesion")
                    self.performSegue(withIdentifier: "entrar", sender: self)
                }else{
                    print("no funciono el login")
                }
                
                
            }
            
        }
    }
    

}

