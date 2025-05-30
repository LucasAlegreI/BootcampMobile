import UIKit

class PuntajeTocameViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var puntajesTable: UITableView!
    var puntajes : [(String,String)] = []
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
        let item = puntajes[indexPath.row]
        cell.textLabel?.text = item.0
        cell.detailTextLabel?.text = "Puntaje: \(item.1)"
        return cell
    }
}
