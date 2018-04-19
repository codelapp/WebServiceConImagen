import UIKit
import Alamofire

struct Contacto: Codable {
    let nombre : String
    let email : String
    let id: String
    let imagen : String
}

class MostrarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tabla: UITableView!
    
    var contactos = [Contacto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datos()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        datos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CeldaTableViewCell
        let contacto = contactos[indexPath.row]
        cell.nombre.text = contacto.nombre
        cell.email.text = contacto.email
        
        Alamofire.request(contacto.imagen).responseData { (response) in
            if response.error == nil {
                if let data = response.data {
                    cell.imagen.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            if let id = tabla.indexPathForSelectedRow {
            let fila = contactos[id.row]
            let destino = segue.destination as! EditarViewController
                destino.contacto = fila
            }
        }
    }

    func datos(){
        let url = URL(string: "http://127.0.0.1/ws/mostrar.php")
        
        Alamofire.request(url!).responseJSON { (response) in
            let result = response.data
            do{
                self.contactos = try JSONDecoder().decode([Contacto].self, from: result!)
                DispatchQueue.main.async {
                    self.tabla.reloadData()
                }
            }catch{
                print("error al conectar con php")
            }
        }
        // datos
       
        
   
    }

    @IBAction func salir(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sesion")
        dismiss(animated: true, completion: nil)
    }
    
}











