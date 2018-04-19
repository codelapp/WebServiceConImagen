import UIKit
import Alamofire
class RegistrarViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var respuesta: UILabel!
    
    var url_registrar = "http://127.0.0.1/ws/registrar.php"
    
    var imagen = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resgistrar(_ sender: UIButton) {
        /*
        let parametros : Parameters = [
            "usuario": user.text!,
            "pass": pass.text!,
            "nombre": name.text!,
            "email": email.text!
        ]
        
        Alamofire.request(url_registrar, method: .post, parameters: parametros).responseJSON { (response) in
            print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                self.respuesta.text = jsonData.value(forKey: "mensaje") as! String?
            }
            
        }
 */
        
        let parametros : Parameters = [
            "usuario": user.text!,
            "pass": pass.text!,
            "nombre": name.text!,
            "email": email.text!
        ]
        
        let imagenFinal = UIImagePNGRepresentation(imagen)
        let nombreImagen = UUID().uuidString
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imagenFinal!, withName: "imagen", fileName: "\(nombreImagen).png", mimeType: "image/png")
            
            for (key, val) in parametros {
                multipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, to: url_registrar) { (resultado) in
            
            switch resultado {
                
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    print(response)
                })
            case .failure(let error):
                print("error al subir imagen y registrar", error)
            }
            
        }
        
        
        
        
        
        
    }// termina registrar
    
    @IBAction func regresar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func galeria(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenTomada = info[UIImagePickerControllerEditedImage] as? UIImage
        imagen = imagenTomada!
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
