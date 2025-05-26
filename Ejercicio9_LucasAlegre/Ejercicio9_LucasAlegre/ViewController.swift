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
        if ganador == 0 {
            shotAlert(textToShow: "El ganador es: " + player1Name.text!)
            player1Hand.backgroundColor = .green
            player2Hand.backgroundColor = .red
        } else if ganador == 1 {
            shotAlert(textToShow: "El ganador es: " + player2Name.text!)
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
    
    func hidePlayersHand(hide: Bool) {
        player1Hand.isHidden = hide
        player2Hand.isHidden = hide
        player1Name.isHidden = !hide
        player2Name.isHidden = !hide
        if let superview = playButton.superview {
            for constraint in superview.constraints {
                if constraint.firstItem as? UIView == playButton || constraint.secondItem as? UIView == playButton {
                    superview.removeConstraint(constraint)
                }
            }
        }
        playButton.translatesAutoresizingMaskIntoConstraints = false
        if hide{
            NSLayoutConstraint.activate([
                playButton.topAnchor.constraint(equalTo: player2Name.bottomAnchor, constant: 25),
                playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 102),
                playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -102),
                playButton.heightAnchor.constraint(equalToConstant: 34)
                
            ])
        }else{
            NSLayoutConstraint.activate([
                playButton.topAnchor.constraint(equalTo: player2Hand.bottomAnchor, constant: 25),
                playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 102),
                playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -102),        
                playButton.heightAnchor.constraint(equalToConstant: 34)
            ])
        }
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
