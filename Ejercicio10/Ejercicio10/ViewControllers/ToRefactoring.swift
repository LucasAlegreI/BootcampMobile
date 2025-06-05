//
//
//@IBOutlet weak var top5Button: UIButton!
//@IBOutlet weak var nameLabel: UILabel!
//@IBOutlet weak var puntajeLabel: UILabel!
//@IBOutlet weak var areaInstanciable: UIView!
//@IBOutlet weak var temporizadorLabel: UILabel!
//let timerController = TimerControler()
//let top5Controller = Top5Controller()
//let tocameButtonsController = TocameButtonsController()
//var playing = false
//var puntaje = 0
//var nombreJugador = ""
//override func viewDidLoad() {
//    super.viewDidLoad()
//    Start()
//}
//func Start(){
//    nameLabel.text = nombreJugador
//    puntajeLabel.text = "0"
//    top5Controller.chargeTop5()
//    tocameButtonsController.setRefreshPuntaje(newRefreshPuntaje: refreshPuntaje)
//    tocameButtonsController.setMax(areaInstanciable: areaInstanciable)
//}
//@IBAction func top5ButtonAction(_ sender: Any) {
//    let puntajeTocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PuntajeTocameViewController") as! PuntajeTocameViewController
//    Task{
//        if let token = UserDefaults.standard.string(forKey: "Token"){
//            puntajeTocameViewController.puntajes = await ScoreUseCase().getListOfScores(token: token)
//        }
//        puntajeTocameViewController.modalPresentationStyle = .automatic
//        puntajeTocameViewController.modalTransitionStyle = .coverVertical
//        present(puntajeTocameViewController, animated: true, completion: nil)
//    }
//}
//func onFinish(){
//    tocameButtonsController.botonCreado?.removeFromSuperview()
//    playing=false
//    addScoreToTop()
//    top5Button.isHidden=false
//}
//func addScoreToTop(){
//    if let token=UserDefaults.standard.string(forKey: "Token"),let id = UserDefaults.standard.string(forKey: "Id"), let score = Int(puntajeLabel.text!.replacingOccurrences(of: "Puntaje: ", with: "")){
//        Task{
//            await ScoreUseCase().createScore(token: token, userId: id, score: score)
//        }
//    }
//}
//func refreshPuntaje(){
//    puntaje+=1
//    puntajeLabel.text="Puntaje: \(puntaje)"
//}
//@IBAction func jugarButtonAction(_ sender: Any) {
//    if !playing{
//        tocameButtonsController.crearNuevoButton(areaInstanciable: areaInstanciable)
//        top5Button.isHidden=true
//        timerController.startTimer(temporizadorLabel: temporizadorLabel,onFinish: onFinish)
//        puntaje=0
//        puntajeLabel.text="Puntaje: \(puntaje)"
//        playing=true
//    }
//}
