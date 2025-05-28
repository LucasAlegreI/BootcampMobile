import UIKit

class TocameViewController: UIViewController {
    // Mark: -Jugador
    @IBOutlet weak var top5Button: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    var nombreJugador = ""
    @IBOutlet weak var puntajeLabel: UILabel!
    var puntaje = 0
    var botonCreado : UIButton?
    let anchoBoton: CGFloat = 30
    let altoBoton: CGFloat = 30
    var maxX : Double?
    var maxY : Double?
    @IBOutlet weak var areaInstanciable: UIView!
    @IBOutlet weak var temporizadorLabel: UILabel!
    var timer: Timer?
    var secondsRemaining = 30
    var playing = false
    var top5 : [String:Int] = [:]
    var top5Ordenado : [(String,Int)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nombreJugador + ":"
        puntajeLabel.text = "0"
        maxX = areaInstanciable.bounds.width - anchoBoton
        maxY = areaInstanciable.bounds.height - altoBoton
        chargeTop5()
    }
    func generateRandomPosition()->(Double,Double){
        (Double.random(in: 0...maxX!),Double.random(in: 0...maxY!))
    }
    func chargeTop5(){
        top5 = UserDefaults.standard.dictionary(forKey: "Top5")?.compactMapValues{$0 as? Int} ?? [:]
        sortTop5()
    }
    func sortTop5(){
        top5Ordenado = top5.sorted {
            if $0.value != $1.value {
                return $0.value > $1.value // Primero por puntaje descendente
            } else {
                return $0.key < $1.key     // Luego por nombre ascendente
            }
        }
        .map { ($0.key, $0.value) }
    }
    @IBAction func top5ButtonAction(_ sender: Any) {
        let puntajeTocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PuntajeTocameViewController") as! PuntajeTocameViewController
        puntajeTocameViewController.puntajes = top5Ordenado
        navigationController?.pushViewController(puntajeTocameViewController, animated: true)
    }
    func findNewKey(newKey : String)->String{
        var keyToReturn = ""
        repeat{
            keyToReturn = newKey + String(Int.random(in: 0...9))
        }while isTopContainKey(key: keyToReturn)
        return keyToReturn
    }
    func isTopContainKey(key : String)->Bool{
        for i in top5.keys{
            if i==key{
                return true
            }
        }
        return false
    }
    func addScoreToTop5(score:(String,Int)){
        top5[findNewKey(newKey: score.0)] = score.1
        sortTop5()
        if top5.count>5{
            top5.removeValue(forKey: top5Ordenado[top5Ordenado.count-1].0)
        }
        sortTop5()
        UserDefaults.standard.set(top5, forKey: "Top5")
    }
    func moveRandomButton(){
        let position=generateRandomPosition()
        if botonCreado==nil {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.botonCreado!.frame.origin = CGPoint(x: position.0, y: position.1)
        }
    }
    @objc func newButtonAction(){
        moveRandomButton()
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
                addScoreToTop5(score: (nombreJugador,puntaje) )
                top5Button.isHidden=false
            }
        }
    }
    func crearNuevoButton(){
        let position=generateRandomPosition()
        botonCreado = UIButton(type: .system)
        botonCreado!.frame = CGRect(x:position.0,y:position.1,width: anchoBoton,height: altoBoton)
        botonCreado!.backgroundColor = .blue
        botonCreado!.layer.cornerRadius = anchoBoton/2
        botonCreado!.addTarget(self, action: #selector(newButtonAction), for: .touchUpInside)
        areaInstanciable.addSubview(botonCreado!)
    }
    @IBAction func jugarButtonAction(_ sender: Any) {
        if !playing{
            crearNuevoButton()
            top5Button.isHidden=true
            startTimer()
            puntaje=0
            puntajeLabel.text="0"
            playing=true
        }
    }
}
