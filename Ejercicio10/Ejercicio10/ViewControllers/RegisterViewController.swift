import UIKit

class RegisterViewController: UIViewController {
    let passwordTxtField = UITextField()
    let correoTxtField = UITextField()
    let passwordLabel = UILabel()
    let correoLabel = UILabel()
    let newButton = UIButton()
    let authService = AuthService()
    var textFields : [UITextField] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureLabels()
        configureStacksViews()
    }
    func configureStacksViews(){
        let correoField = UIStackView(arrangedSubviews: [correoLabel,correoTxtField])
        let passwordField = UIStackView(arrangedSubviews: [passwordLabel,passwordTxtField])
        let fields = [passwordField,correoField]
        for field in fields{
            field.axis = .horizontal
            field.alignment = .fill
            field.distribution = .fill
        }
        let stackView = UIStackView(arrangedSubviews: [correoField,passwordField])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        configureButton(bottomAnchor: stackView.bottomAnchor)
    }
    func configureButton(bottomAnchor: NSLayoutYAxisAnchor){
        view.addSubview(newButton)
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.setTitle("Register", for: .normal)
        newButton.setTitleColor(UIColor(red: 199/255, green: 172/255, blue: 61/255, alpha: 1), for: .normal)
        newButton.backgroundColor = UIColor(red: 27/255, green: 15/255, blue: 8/255, alpha: 1)
        NSLayoutConstraint.activate([
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newButton.topAnchor.constraint(equalTo: bottomAnchor, constant: 20),
            newButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        newButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    func configureLabels(){
        passwordLabel.text = "Contraseña:"
        correoLabel.text = "Correo:"
        let labels = [correoLabel,passwordLabel]
        for label in labels {
            label.textColor = UIColor(red: 199/255, green: 172/255, blue: 61/255, alpha: 1)
        }
    }
    func configureTextFields(){
        textFields = [correoTxtField,passwordTxtField]
        for textField in textFields{
            textField.widthAnchor.constraint(equalToConstant: 260).isActive=true
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .systemBackground
            textField.autocapitalizationType = .none
        }
        correoTxtField.placeholder = "Correo"
        passwordTxtField.placeholder = "Contraseña"
    }
    func areFieldsEmpty()->Bool{
        for field in textFields {
            if field.text!.isEmpty{
                return true
            }
        }
        return false
    }
    func shotAlert(textToShow: String, onOk: (() -> Void)? = nil) {
        let alerta = UIAlertController(
            title: "¡Advertencia!",
            message: textToShow,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if textToShow=="Se ha registrado exitosamente."{
                self.dismiss(animated: true, completion: nil)
            }
        }        
        alerta.addAction(okAction)
        present(alerta, animated: true, completion: nil)
    }

    @objc func register(){
        if  passwordTxtField.text!.isEmpty || correoTxtField.text!.isEmpty {
            var stringToSend = "Le falta completar los siguiente campos:"
            if correoTxtField.text!.isEmpty{
                stringToSend += "\n Correo"
            }
            if passwordTxtField.text!.isEmpty{
                stringToSend += "\n Contraseña"
            }
            shotAlert(textToShow: stringToSend)
            return
        }
        Task{
            let textForAlert = await authService.signUpAccountService(email: correoTxtField.text!, password: passwordTxtField.text!)
            shotAlert(textToShow:textForAlert)
        }
    }
}

