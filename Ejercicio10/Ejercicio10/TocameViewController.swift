import UIKit

class TocameViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var nombreJugador = ""
    @IBOutlet weak var puntajeLabel: UILabel!
    let anchoBoton: CGFloat = 30
    let altoBoton: CGFloat = 30
    @IBOutlet weak var areaInstanciable: UIView!
    @IBOutlet weak var temporizadorLabel: UILabel!
    var maxX : Double?
    var maxY : Double?
    var timer: Timer?
    var secondsRemaining = 30
    var playing = false
    var botonCreado : UIButton?
    var puntaje = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nombreJugador + ":"
        puntajeLabel.text = "0"
        maxX = areaInstanciable.bounds.width - anchoBoton
        maxY = areaInstanciable.bounds.height - altoBoton
    }
    func generateRandomPosition()->(Double,Double){
        (Double.random(in: 0...maxX!),Double.random(in: 0...maxY!))
    }
    func createRandomButton(){
        let boton = UIButton(type : .system)
        let position=generateRandomPosition()
        boton.frame = CGRect(x:position.0,y:position.1,width: anchoBoton,height: altoBoton)
        boton.backgroundColor = .black
        boton.addTarget(self, action: #selector(newButtonAction), for: .touchUpInside)
        areaInstanciable.addSubview(boton)
        botonCreado=boton
    }
    @objc func newButtonAction(){
        botonCreado?.removeFromSuperview()
        createRandomButton()
        puntaje+=1
        puntajeLabel.text=String(puntaje)
    }
    func startTimer() {
        secondsRemaining=30
        temporizadorLabel.text = "\(secondsRemaining)"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                self.temporizadorLabel.text = "\(self.secondsRemaining)"
            } else {
                botonCreado?.removeFromSuperview()
                self.timer?.invalidate()
                self.timer = nil
                self.temporizadorLabel.text = "¡Tiempo!"
                playing=false
            }
        }
    }
    @IBAction func jugarButtonAction(_ sender: Any) {
        if !playing{
            createRandomButton()
            startTimer()
            puntaje=0
            puntajeLabel.text="0"
            playing=true
        }
    }
}
