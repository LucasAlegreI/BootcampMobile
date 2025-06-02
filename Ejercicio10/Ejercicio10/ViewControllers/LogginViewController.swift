import UIKit
import Alamofire
class LogginViewController: UIViewController {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad()  {
        super.viewDidLoad()
        Task{
            await findAPokemon(by: "5")
        }
        Start()
    }
    func findAPokemon(by nameOrId:String) async{
        let url = "https://pokeapi.co/api/v2/pokemon/\(nameOrId)"
        do{
            let pokemon = try await AF.request(url).validate().serializingDecodable(Pokemon.self).value
            print (pokemon.name)
        } catch{
            print("Error al obtener el Pokémon: \(error)")
        }
    }
    struct Pokemon:Decodable {
        let name: String
        let 
    }
    struct abilities:Decodable{
        let is_hidden : Bool
        let slot : Int
    }
    struct ability:Decodable{
        let name: String
        let url: String
    }
    func Start(){
        //passwordTextField.textContentType = .password
        //passwordTextField.isSecureTextEntry = true
        loginButton.isEnabled=false
        titleImage.layer.cornerRadius=50
        usernameTextField.addTarget(self, action: #selector(isLoginButtonActive), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isLoginButtonActive), for: .editingChanged)
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        let registerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        cleanTxtFields()
        registerViewController.modalPresentationStyle = .automatic // o .pageSheet / .fullScreen
        registerViewController.modalTransitionStyle = .coverVertical
        present(registerViewController, animated: true, completion: nil)
    }
    @objc func isLoginButtonActive(){
        if !usernameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty{
            loginButton.isEnabled=true
        }else{
            loginButton.isEnabled=false
        }
    }
    func cleanTxtFields(){
        usernameTextField.text=""
        passwordTextField.text=""
        loginButton.isEnabled=false
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()

    }
    func shotAlert(textToShow: String) {
            let alerta = UIAlertController(
                title: "¡Advertencia!",
                message: textToShow,
                preferredStyle: .alert
            )
            alerta.addAction(
                UIAlertAction(title: "OK", style: .default, handler: nil)
            )
            present(alerta, animated: true, completion: nil)
        }
    @IBAction func top10ButtonAction(_ sender: Any) {
        let puntajeTocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PuntajeTocameViewController") as! PuntajeTocameViewController
        puntajeTocameViewController.puntajes = SaveReadController().returnPuntajes(numberOfScores: 10)
        puntajeTocameViewController.modalPresentationStyle = .automatic // o .pageSheet / .fullScreen
        puntajeTocameViewController.modalTransitionStyle = .coverVertical
        present(puntajeTocameViewController, animated: true, completion: nil)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        let operationId = SaveReadController().checkLoggin(newUsername: usernameTextField.text!, newPassword: passwordTextField.text!)
        if operationId.0 == 0{
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! MainViewController
            viewController.nameOfUser=operationId.1
            cleanTxtFields()
            navigationController?.pushViewController(viewController, animated: true)
        }else if operationId.0 == 1 {
            shotAlert(textToShow: operationId.1)
        }else{
            shotAlert(textToShow: operationId.1)
        }
    }
}
