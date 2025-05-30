import UIKit

class PokerViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player1Hand: UIStackView!
    @IBOutlet weak var player2Hand: UIStackView!
    var backgrounds: [UIView] = []
    var isPlaying = false
    var player1Name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        player1Label.text = player1Name
        player2Label.text = "Chat gpt"
        StartGame()
    }

    @IBAction func playButtonAction(_ sender: Any) {
            StartGame()
    }
    
    func StartGame(){
        let newPokerController = PokerController()
        checkWinner(ganador: newPokerController.main())
        configurarMano(stack: player1Hand, mano: newPokerController.hand1)
        configurarMano(stack: player2Hand, mano: newPokerController.hand2)
    }
    
    func checkWinner(ganador: Int) {
        if ganador == 0 {
            shotAlert(textToShow: "El ganador es: " + player1Name)
            player1Hand.backgroundColor = .green
            player2Hand.backgroundColor = .red
        } else if ganador == 1 {
            shotAlert(textToShow: "El ganador es: Chat gpt")
            player1Hand.backgroundColor = .red
            player2Hand.backgroundColor = .green
        } else {
            shotAlert(textToShow: "Empate")
            player1Hand.backgroundColor = .blue
            player2Hand.backgroundColor = .blue
        }
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
    
    func configurarMano(stack: UIStackView, mano: [Card]) {
        for i in 0..<stack.arrangedSubviews.count {
            let contenedor = stack.arrangedSubviews[i]
            for subview in contenedor.subviews {
                if let label = subview as? UILabel {
                    label.text = mano[i].valorNumerico
                } else if let imageView = subview as? UIImageView {
                    imageView.image = UIImage(named: mano[i].palo)
                }
            }
        }
    }   
}
