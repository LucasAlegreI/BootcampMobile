import UIKit

class GeneralaViewController: UIViewController {
    @IBOutlet weak var dadosStackView: UIStackView!
    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var reRollButton: UIButton!
    let generalaController = GeneralaController()
    var tiradasRestantes = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        generalaController.rollDices()
        gameTypeLabel.text = generalaController.getGameType()
        configurarDados(stack: dadosStackView)
        reRollButton.setTitle("Tirar dados(\(tiradasRestantes))", for: .normal)
        for view in dadosStackView.arrangedSubviews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.isUserInteractionEnabled = true // MUY IMPORTANTE
            view.addGestureRecognizer(tapGesture)
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let viewTocada = sender.view {
            if viewTocada.backgroundColor == .green{
                viewTocada.backgroundColor = .white
            }else{
                viewTocada.backgroundColor = .green
            }
        }
    }
    func configurarDados(stack: UIStackView) {
        for i in 0..<stack.arrangedSubviews.count {
            let contenedor = stack.arrangedSubviews[i]
            if let label = contenedor.subviews[0] as? UILabel{
                label.text = String(generalaController.dados[i])
            }
        }
    }
    func diceSomeDados(stack: UIStackView){
        var dadosToChange : [Int] = []
        for i in 0..<stack.arrangedSubviews.count {
            let contenedor = stack.arrangedSubviews[i]
            if contenedor.backgroundColor == .green{
                dadosToChange.append(i)
            }
        }
        if dadosToChange.count == 0 {
            return
        }
        tiradasRestantes-=1        
        reRollButton.setTitle("Tirar dados(\(tiradasRestantes))", for: .normal)
        reRollButton.isEnabled = tiradasRestantes != 0
        generalaController.rollSomeDices(dicesToRoll: dadosToChange)
        configurarDados(stack: stack)
        gameTypeLabel.text = generalaController.getGameType()
    }
    @IBAction func reRollButtonAction(_ sender: Any) {
        diceSomeDados(stack: dadosStackView)
    }
}

