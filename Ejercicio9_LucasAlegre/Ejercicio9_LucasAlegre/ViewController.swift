import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var player1Name: UITextField!
    @IBOutlet weak var player2Name: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var player1Hand: UIStackView!
    @IBOutlet weak var player2Hand: UIStackView!
    var backgrounds: [UIView] = []
    var isPlaying = false
    override func viewDidLoad() {
        super.viewDidLoad()
        hidePlayersHand(hide: true)
        playButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    @IBAction func playButtonAction(_ sender: Any) {
        if !isPlaying {
            isPlaying = true
            hidePlayersHand(hide: false)
            playButton.setTitle("Volver a jugar", for: .normal)
            let newPokerController = Poker()
            checkWinner(ganador: newPokerController.main())
            configurarMano(stack: player1Hand, mano: newPokerController.hand1)
            configurarMano(stack: player2Hand, mano: newPokerController.hand2)
        } else {
            isPlaying = false
            playButton.setTitle("Repartir", for: .normal)
            hidePlayersHand(hide: true)
            player1Name.text = ""
            player2Name.text = ""
            playButton.isEnabled = false
        }
    }
    
    func checkWinner(ganador: Int) {
        for i in backgrounds {
            i.removeFromSuperview()
        }
        backgrounds.removeAll()
        if ganador == 0 {
            shotAlert(textToShow: "El ganador es: " + player1Name.text!)
            addBackground(stackView: player1Hand, color: .green)
            addBackground(stackView: player2Hand, color: .red)
        } else if ganador == 1 {
            shotAlert(textToShow: "El ganador es: " + player2Name.text!)
            addBackground(stackView: player2Hand, color: .green)
            addBackground(stackView: player1Hand, color: .red)
        } else {
            shotAlert(textToShow: "Empate")
            addBackground(stackView: player1Hand, color: .blue)
            addBackground(stackView: player2Hand, color: .blue)
        }
    }
    
    func addBackground(stackView: UIStackView, color: UIColor) {
        let fondo = UIView()
        fondo.backgroundColor = color
        fondo.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(fondo, at: 0)
        NSLayoutConstraint.activate([
            fondo.topAnchor.constraint(equalTo: stackView.topAnchor),
            fondo.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            fondo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            fondo.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
        ])
        backgrounds.append(fondo)
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
    
    func hidePlayersHand(hide: Bool) {
        player1Hand.isHidden = hide
        player2Hand.isHidden = hide
        player1Name.isHidden = !hide
        player2Name.isHidden = !hide
    }
    
    @IBAction func player1NameChanged(_ sender: Any) {
        if !player2Name.text!.isEmpty && !player1Name.text!.isEmpty {
            playButton.isEnabled = true
        } else {
            playButton.isEnabled = false
        }
    }
    
    @IBAction func player2NameChanged(_ sender: Any) {
        if !player2Name.text!.isEmpty && !player1Name.text!.isEmpty {
            playButton.isEnabled = true
        } else {
            playButton.isEnabled = false
        }
    }

}
