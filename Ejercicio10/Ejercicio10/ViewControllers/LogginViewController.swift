import UIKit
import Alamofire
class LogginViewController: UIViewController {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad()  {
        super.viewDidLoad()
        Start()
    }
    func Start(){
        //passwordTextField.textContentType = .password
        //passwordTextField.isSecureTextEntry = true
        loginButton.isEnabled=false
        titleImage.layer.cornerRadius=50
        emailTextField.addTarget(self, action: #selector(isLoginButtonActive), for: .editingChanged)
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
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty{
            loginButton.isEnabled=true
        }else{
            loginButton.isEnabled=false
        }
    }
    func cleanTxtFields(){
        emailTextField.text=""
        passwordTextField.text=""
        loginButton.isEnabled=false
        emailTextField.resignFirstResponder()
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
    func pushToMainViewController(){
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! MainViewController
        cleanTxtFields()
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        Task{
            let message = await AuthService().loginAccountService(email: emailTextField.text!, password: passwordTextField.text!)
            if message == "Bienvenido \(emailTextField.text!)"{
                pushToMainViewController()
            }else{
                shotAlert(textToShow: message)
            }
        }
    }
}
