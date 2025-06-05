import UIKit

class TocameViewController: UIViewController {
    let puntajeLabel = UILabel()
    let playerNameLabel = UILabel()
    let timerLabel = UILabel()
    let jugarButton = UIButton()
    let topButton = UIButton()
    let instanciableArea = UIView()
    
    var puntaje = 0
    var playing=false
    var botonCreado : UIButton?
    let anchoBoton: CGFloat = 30
    let altoBoton: CGFloat = 30
    var maxX : Double?
    var maxY : Double?
    
    var timer: Timer?
    var secondsRemaining = 30
    var didSetMax = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupButtons()
        setupAreaInstanciable()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !didSetMax {
            setMax()
            didSetMax = true
        }
    }
    
    func setupLabels(){
        timerLabel.textAlignment = .right
        timerLabel.font = .systemFont(ofSize: 18)
        timerLabel.text="Timer"
        timerLabel.textColor = Constants.fontColor
        puntajeLabel.textAlignment = .center
        puntajeLabel.font = .systemFont(ofSize: 18)
        puntajeLabel.text="Puntaje"
        puntajeLabel.textColor = Constants.fontColor
        playerNameLabel.textAlignment = .left
        playerNameLabel.font = .systemFont(ofSize: 18)
        playerNameLabel.text="Jugador"
        playerNameLabel.textColor = Constants.fontColor
        view.addSubview(timerLabel)
        view.addSubview(puntajeLabel)
        view.addSubview(playerNameLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints=false
        puntajeLabel.translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            puntajeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            puntajeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        ])
    }
    
    func setupButtons(){
        jugarButton.setTitle("Jugar", for: .normal)
        jugarButton.titleLabel?.font = .systemFont(ofSize: 24)
        jugarButton.addTarget(self, action: #selector(jugarButtonAction), for: .touchUpInside)
        jugarButton.setTitleColor(Constants.fontColor, for: .normal)
        view.addSubview(jugarButton)
        topButton.setTitle("Top", for: .normal)
        topButton.titleLabel?.font = .systemFont(ofSize: 24)
        topButton.addTarget(self, action: #selector(topButtonAction), for: .touchUpInside)
        topButton.setTitleColor(Constants.fontColor, for: .normal)
        view.addSubview(topButton)
        jugarButton.translatesAutoresizingMaskIntoConstraints = false
        topButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jugarButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            jugarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            topButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAreaInstanciable (){
        instanciableArea.backgroundColor = Constants.fillColor
        view.addSubview(instanciableArea)
        instanciableArea.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            instanciableArea.topAnchor.constraint(equalTo: puntajeLabel.bottomAnchor,constant: 10),
            instanciableArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            instanciableArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            instanciableArea.bottomAnchor.constraint(equalTo: jugarButton.topAnchor, constant: -20)
        ])
    }
    
    func setMax(){
        maxX = instanciableArea.bounds.width - anchoBoton
        maxY = instanciableArea.bounds.height - altoBoton
    }
    
    func generateRandomPosition()->(Double,Double){
        (Double.random(in: 0...maxX!),Double.random(in: 0...maxY!))
    }
    
    func crearNuevoButton(){
        let position=generateRandomPosition()
        botonCreado = UIButton(type: .system)
        botonCreado!.frame = CGRect(x:position.0,y:position.1,width: anchoBoton,height: altoBoton)
        botonCreado!.backgroundColor = UIColor(red: 199/255, green: 172/255, blue: 61/255, alpha: 1)
        botonCreado!.layer.cornerRadius = anchoBoton/2
        botonCreado!.addTarget(self, action: #selector(newButtonAction), for: .touchUpInside)
        instanciableArea.addSubview(botonCreado!)
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
    
    func refreshPuntaje(){
        puntaje+=1
        puntajeLabel.text="Puntaje: \(puntaje)"
    }
    
    func startTimer() {
        secondsRemaining=30
        timerLabel.text = "\(secondsRemaining)"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                timerLabel.text = "\(self.secondsRemaining)"
            } else {
                self.timer?.invalidate()
                self.timer = nil
                timerLabel.text = "¡Tiempo!"
                onFinish()
            }
        }
    }
    
    func onFinish(){
        botonCreado?.removeFromSuperview()
        playing=false
        addScoreToTop()
        topButton.isHidden=false
    }
    
    func addScoreToTop(){
        if let token=UserDefaults.standard.string(forKey: "Token"),let id = UserDefaults.standard.string(forKey: "Id"), let score = Int(puntajeLabel.text!.replacingOccurrences(of: "Puntaje: ", with: "")){
            Task{
                await ScoreUseCase().createScore(token: token, userId: id, score: score)
            }
        }
    }
    
    @objc func newButtonAction(){
        moveRandomButton()
        refreshPuntaje()
    }
    
    @objc func jugarButtonAction(){
        if !playing{
            crearNuevoButton()
            topButton.isHidden=true
            startTimer()
            puntaje=0
            puntajeLabel.text="Puntaje: \(puntaje)"
            playing=true
        }
    }
    
    @objc func topButtonAction(){
        let puntajeTocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PuntajeTocameViewController") as! PuntajeTocameViewController
        Task{
            if let token = UserDefaults.standard.string(forKey: "Token"){
                puntajeTocameViewController.puntajes = await ScoreUseCase().getListOfScores(token: token)
            }
            puntajeTocameViewController.modalPresentationStyle = .automatic
            puntajeTocameViewController.modalTransitionStyle = .coverVertical
            present(puntajeTocameViewController, animated: true, completion: nil)
        }
    }
}
