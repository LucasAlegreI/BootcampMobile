import UIKit

class MainViewController: UIViewController  {
    @IBOutlet weak var gameTypeImage: UIImageView!
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var textToPicker: UITextField!
    let gamesNames = ["Poker", "Tocame", "Generala"]
    let gamePicker = UIPickerView()
    var selectedGameIndex: Int = 0
    var nameOfUser = ""
    @IBOutlet weak var ayudaLabel: UILabel!
    let pokerDescription = "Juega contra chatgpt una mano de poker, el que tenga mejor mano gana, el orden de juego es el siguiente: Escalera a color, poker, full house, color, escalera, trio, doble par y carta alta, en el caso de que ambos jugadores tengan el mismo juego se define por quien tenga la carta mas alta en su mano, si tienen la misma mano es empate."
    let generalaDescription = "Tira los dados para lograr el mejor juego posible, el orde de juego es el siguiente: generala(5 dados iguales), poker(4 dados iguales), full house(3 dados de un valor, y dos de otro valor) y escalera(5 dados con valores consecutivos."
    let tocameDescription = "Intenta batir tu record, cada vez que selecciones el circulo cambiara de posicion y ganaras un punto, compite contra vos mismo y contra los demas usuarios por tener la mayor cantidad de puntos."
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerStart()
        labelsStart()
    }
    func labelsStart(){
        ayudaLabel.numberOfLines = 0
        ayudaLabel.lineBreakMode = .byWordWrapping
        welcomeTitleLabel.text = "Bienvenido \(nameOfUser)"
    }
    func pickerStart(){
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
    }
    @IBAction func ayudaButtonAction(_ sender: Any) {
        if !ayudaLabel.text!.isEmpty{
            ayudaLabel.text=""
            return
        }
        changeAyudaLabel()
    }
    func changeAyudaLabel(){
        if selectedGameIndex==0{
            ayudaLabel.text=pokerDescription
        }else if selectedGameIndex==1{
            ayudaLabel.text=tocameDescription
        }else{
            ayudaLabel.text=generalaDescription
        }
    }
    
    // Picker: cantidad de columnas
    
    @IBAction func jugarButtonAction(_ sender: Any) {
        cerrarPicker()
        if selectedGameIndex == 0{
            pushToPokerWindow()
        }else if selectedGameIndex == 1{
            pushToTocameWindow()
        }else if selectedGameIndex == 2{
            pushToGenerala()
        }
    }
    
    // Picker: título por fila
    
    func changeGameTypeImage(){
        if selectedGameIndex == 0{
            gameTypeImage.image=UIImage(named: "Poker")
        }else if selectedGameIndex==1{
            gameTypeImage.image=UIImage(named: "Tocame")
        }else {
            gameTypeImage.image=UIImage(named: "Generala")
        }
    }
    func pushToPokerWindow(){
        let pokerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokerViewController") as! PokerViewController
        pokerViewController.player1Name=nameOfUser
        navigationController?.pushViewController(pokerViewController, animated: true)
    }
    func pushToGenerala(){
        let generalaViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GeneralaViewController") as! GeneralaViewController
        navigationController?.pushViewController(generalaViewController, animated: true)
    }
    func pushToTocameWindow(){
        let tocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TocameViewController") as! TocameViewController
        tocameViewController.nombreJugador=nameOfUser
        navigationController?.pushViewController(tocameViewController, animated: true)
    }
    
    @objc func cerrarPicker() {
        textToPicker.resignFirstResponder()
    }
}
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    @IBAction func misPuntajesButtonAction(_ sender: Any) {
        let puntajeTocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PuntajeTocameViewController") as! PuntajeTocameViewController
        puntajeTocameViewController.puntajes = SaveReadController().returnPuntajes(username: nameOfUser)
        puntajeTocameViewController.modalPresentationStyle = .automatic // o .pageSheet / .fullScreen
        puntajeTocameViewController.modalTransitionStyle = .coverVertical
        present(puntajeTocameViewController, animated: true, completion: nil)
    }
    
    // Picker: cantidad de filas
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        gamesNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        gamesNames[row]
    }

    // Al seleccionar una fila
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textToPicker.text = gamesNames[row]
        selectedGameIndex = row
        changeGameTypeImage()
        if ayudaLabel.text!.isEmpty{
            return
        }
        changeAyudaLabel()
    }
}
