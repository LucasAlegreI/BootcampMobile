import UIKit

class PuntajeTocameViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var puntajesTable: UITableView!
    var puntajes : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        puntajesTable.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        puntajes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Puntaje: \(puntajes[indexPath.row])"
        return cell
    }
}
