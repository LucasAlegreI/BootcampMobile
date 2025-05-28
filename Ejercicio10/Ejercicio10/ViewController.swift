import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textToPicker: UITextField!
    @IBOutlet weak var usuario1Label: UILabel!
    @IBOutlet weak var usuario2TxtField: UITextField!
    @IBOutlet weak var usuario2Label: UILabel!
    @IBOutlet weak var usuario1TxtField: UITextField!
    @IBOutlet weak var jugarButton: UIButton!
    let gamesNames = ["Poker", "Tocame", "Generala"]
    let gamePicker = UIPickerView()
    var selectedGameIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        textToPicker.tintColor = .clear
        gamePicker.delegate = self
        gamePicker.dataSource = self
        textToPicker.delegate = self
        textToPicker.inputView = gamePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(cerrarPicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textToPicker.inputAccessoryView = toolbar
        pickerView(gamePicker, didSelectRow: 0, inComponent: 0)
        jugarButton.isEnabled=false
    }
    func deleteTopConstrainstJugarButton(){
        if let superview = jugarButton.superview {
            for constraint in superview.constraints {
                if (constraint.firstItem as? UIView == jugarButton && constraint.firstAttribute == .top) ||
                   (constraint.secondItem as? UIView == jugarButton && constraint.secondAttribute == .top) {
                    superview.removeConstraint(constraint)
                }
            }
        }
        jugarButton.translatesAutoresizingMaskIntoConstraints = false
    }
    @IBAction func usuario1TxtFieldChanged(_ sender: Any) {
        verifyButtonEnabled()
    }
    @IBAction func usuario2TxtFieldChanged(_ sender: Any) {
        verifyButtonEnabled()
    }
    
    // Picker: cantidad de columnas
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false // impide escribir manualmente
    }
    
    // Picker: cantidad de filas
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        gamesNames.count
    }

    // Picker: título por fila
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        gamesNames[row]
    }

    // Al seleccionar una fila
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textToPicker.text = gamesNames[row]
        selectedGameIndex = row
        if (row==0){
            changeTxtFieldsLocation(twoTxtFields: true)
        }else if row == 1{
            changeTxtFieldsLocation(twoTxtFields: false)
        }else if row == 2{
            changeTxtFieldsLocation(twoTxtFields: false)
        }
    }
    func changeTxtFieldsLocation(twoTxtFields:Bool){
        deleteTopConstrainstJugarButton()
        if twoTxtFields{
            NSLayoutConstraint.activate([
                jugarButton.topAnchor.constraint(equalTo: usuario2TxtField.bottomAnchor, constant: 8)
            ])
            usuario2Label.isHidden=false
            usuario2TxtField.isHidden=false
        }else {
            NSLayoutConstraint.activate([
                jugarButton.topAnchor.constraint(equalTo: usuario1TxtField.bottomAnchor, constant: 8)
            ])
            usuario2Label.isHidden=true
            usuario2TxtField.isHidden=true
        }
        verifyButtonEnabled()
    }
    func verifyButtonEnabled(){
        if selectedGameIndex==0{
            if !usuario1TxtField.text!.isEmpty && !usuario2TxtField.text!.isEmpty{
                jugarButton.isEnabled=true
            }else {
                jugarButton.isEnabled=false
            }
        }else if selectedGameIndex == 1||selectedGameIndex == 2{
            if !usuario1TxtField.text!.isEmpty{
                jugarButton.isEnabled=true
            }else {
                jugarButton.isEnabled=false
            }
        }
    }
    @IBAction func jugarButtonAction(_ sender: Any) {
        if selectedGameIndex==0{
            pushToPokerWindow()
        }else if selectedGameIndex == 1{
            pushToTocameWindow()
        }else if selectedGameIndex == 2{
            pushToGenerala()
        }
    }
    func pushToPokerWindow(){
        let pokerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokerViewController") as! PokerViewController
        pokerViewController.player1Name=usuario1TxtField.text!
        pokerViewController.player2Name=usuario2TxtField.text!
        clearTxtFields()
        navigationController?.pushViewController(pokerViewController, animated: true)
    }
    func clearTxtFields(){
        usuario1TxtField.text=""
        usuario2TxtField.text=""
        jugarButton.isEnabled=false
    }
    func pushToGenerala(){
        let generalaViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GeneralaViewController") as! GeneralaViewController
        clearTxtFields()
        navigationController?.pushViewController(generalaViewController, animated: true)
    }
    func pushToTocameWindow(){
        let tocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TocameViewController") as! TocameViewController
        tocameViewController.nombreJugador=usuario1TxtField.text!
        clearTxtFields()
        navigationController?.pushViewController(tocameViewController, animated: true)
    }
    
    @objc func cerrarPicker() {
        textToPicker.resignFirstResponder()
    }
}
