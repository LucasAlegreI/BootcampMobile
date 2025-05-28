import UIKit

class PuntajeTocameViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var puntajesTable: UITableView!
    var puntajes : [(String,Int)] = []
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
        var item = puntajes[indexPath.row]
        item.0.removeLast()
        cell.textLabel?.text = item.0
        cell.detailTextLabel?.text = "Puntaje: \(item.1)"
        return cell
    }
}
