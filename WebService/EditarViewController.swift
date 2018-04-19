import UIKit
import Alamofire
class EditarViewController: UIViewController {
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var contacto: Contacto!
    var id = ""
    var url_editar = "http://127.0.0.1/ws/actualizar.php"
    var url_borrar = "http://127.0.0.1/ws/borrar.php"
    var respuesta = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.text = contacto.nombre
        email.text = contacto.email
        id = contacto.id
    }

    @IBAction func actualizar(_ sender: UIButton) {
        
        let parametros : Parameters = [
            "nombre": nombre.text!,
            "email": email.text!,
            "id":id
        ]
        
        Alamofire.request(url_editar, method: .post, parameters: parametros).responseJSON { (response) in
            print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                self.respuesta = (jsonData.value(forKey: "mensaje") as! String?)!
                
                if self.respuesta == "edito completo"{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("no funciono el login")
                }
                
                
            }
            
        }
        
    }
    
    @IBAction func eliminar(_ sender: UIButton) {
        
        let parametros : Parameters = [
            "id":id
        ]
        
        Alamofire.request(url_borrar, method: .post, parameters: parametros).responseJSON { (response) in
            print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                self.respuesta = (jsonData.value(forKey: "mensaje") as! String?)!
                
                if self.respuesta == "borro completo"{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("no funciono el login")
                }
                
                
            }
            
        }
        
    }
    
    @IBAction func cancelar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
