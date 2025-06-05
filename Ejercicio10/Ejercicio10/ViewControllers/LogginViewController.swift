import UIKit
class LogginViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let titleImage = UIImageView()
    let loginButton = UIButton()
    let registerButton = UIButton()
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        setupTitleImage()
        setupTextFields()
        setupButtons()
    }
    
    func setupTitleImage(){
        titleImage.image = UIImage(named:"Poker")
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        NSLayoutConstraint.activate([
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImage.topAnchor.constraint (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleImage.heightAnchor.constraint(equalToConstant: 200),
            titleImage.widthAnchor.constraint(equalToConstant: 200)
        ])
        titleImage.layer.cornerRadius=50
        titleImage.clipsToBounds = true
    }
    
    func setupTextFields(){
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = .systemBackground
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholder = "Email"
        emailTextField.textAlignment = .center
        emailTextField.addTarget(self, action: #selector(isLoginButtonActive), for: .editingChanged)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .systemBackground
        passwordTextField.autocapitalizationType = .none
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.addTarget(self, action: #selector(isLoginButtonActive), for: .editingChanged)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 240),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 240),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupButtons(){
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 24)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginButton.setTitleColor(Constants.fontColor, for: .normal)
        view.addSubview(loginButton)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 24)
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        registerButton.setTitleColor(Constants.fontColor, for: .normal)
        view.addSubview(registerButton)
        loginButton.translatesAutoresizingMaskIntoConstraints=false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 20),
            registerButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        loginButton.isEnabled = false
    }
    
    func resetFields(){
        emailTextField.text=""
        passwordTextField.text=""
        loginButton.isEnabled=false
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()    
    }
    
    func pushToMainViewController(){
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! MainViewController
        resetFields()
        navigationController?.pushViewController(mainViewController, animated: true)
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
    
    @objc func isLoginButtonActive(){
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty{
            loginButton.isEnabled=true
        }else{
            loginButton.isEnabled=false
        }
    }
    
    @objc func loginButtonAction(){
        Task{
            let message = await AuthUseCase().logginAccount(email: emailTextField.text!, password: passwordTextField.text!)
            if message == "Bienvenido \(emailTextField.text!)"{
                pushToMainViewController()
            }else{
                shotAlert(textToShow: message)
            }
        }
    }
    
    @objc func registerButtonAction(){
        let registerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        resetFields()
        registerViewController.modalPresentationStyle = .automatic // o .pageSheet / .fullScreen
        registerViewController.modalTransitionStyle = .coverVertical
        present(registerViewController, animated: true, completion: nil)
    }
}
