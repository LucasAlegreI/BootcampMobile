import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    let leftButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)
    let jugarButton = UIButton(type: .system)
    let misPuntajesButton = UIButton(type: .system)
    let ayudaButton = UIButton (type: .system)
    let ayudaLabel = UILabel()
    let imageNames = ["Poker", "Tocame", "Generala"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupPages()
        setupPageControl()
        setupDirectionsButtons()
        updateUI(for: 0)
        setupjugarButton()
        setupMisPuntajesButton()
        setupAyuda()
        updateNavigationButtonsState()
    }

    func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupPages() {
        for (index, name) in imageNames.enumerated() {
            let imageView = UIImageView()
            imageView.image = UIImage(named: name)
            imageView.contentMode = .scaleToFill
            scrollView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(index) * view.frame.width)
            ])
        }
        scrollView.contentSize = CGSize(width: CGFloat(imageNames.count) * view.frame.width, height: 300)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupjugarButton(){
        jugarButton.setTitle("Jugar", for: .normal)
        jugarButton.titleLabel?.font = .systemFont(ofSize: 24)
        jugarButton.addTarget(self, action: #selector(jugarButtonAction), for: .touchUpInside)
        jugarButton.tintColor = Constants.fontColor
        view.addSubview(jugarButton)
        jugarButton.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            jugarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jugarButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: 20),
            jugarButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupMisPuntajesButton(){
        misPuntajesButton.setTitle("Mis Puntajes", for: .normal)
        misPuntajesButton.titleLabel?.font = .systemFont(ofSize: 24)
        misPuntajesButton.addTarget(self, action: #selector(misPuntajesButtonAction), for: .touchUpInside)
        misPuntajesButton.tintColor = Constants.fontColor
        view.addSubview(misPuntajesButton)
        misPuntajesButton.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            misPuntajesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            misPuntajesButton.topAnchor.constraint(equalTo: jugarButton.bottomAnchor,constant: 20),
            misPuntajesButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupAyuda(){
        ayudaButton.setTitle("Ayuda", for: .normal)
        ayudaButton.titleLabel?.font = .systemFont(ofSize: 24)
        ayudaButton.addTarget(self, action: #selector(ayudaButtonAction), for: .touchUpInside)
        ayudaButton.tintColor = Constants.fontColor
        view.addSubview(ayudaButton)
        ayudaButton.translatesAutoresizingMaskIntoConstraints=false
        ayudaLabel.textAlignment = .justified
        ayudaLabel.font = .systemFont(ofSize: 18)
        ayudaLabel.numberOfLines = 0
        ayudaLabel.lineBreakMode = .byWordWrapping
        ayudaLabel.translatesAutoresizingMaskIntoConstraints=false
        ayudaLabel.text=""
        ayudaLabel.textColor = Constants.fontColor
        view.addSubview(ayudaLabel)
        NSLayoutConstraint.activate([
            ayudaLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            ayudaLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            ayudaLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ayudaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ayudaButton.bottomAnchor.constraint(equalTo: ayudaLabel.topAnchor),
            ayudaButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupDirectionsButtons() {
        leftButton.setTitle("←", for: .normal)
        rightButton.setTitle("→", for: .normal)
        leftButton.titleLabel?.font = .systemFont(ofSize: 24)
        rightButton.titleLabel?.font = .systemFont(ofSize: 24)
        leftButton.tintColor=Constants.fontColor
        rightButton.tintColor=Constants.fontColor
        leftButton.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        UserDefaults.standard.string(forKey: <#T##String#>)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rightButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func updateNavigationButtonsState(){
        if pageControl.currentPage==0{
            leftButton.isEnabled=false
            rightButton.isEnabled=true
        }else if pageControl.currentPage == pageControl.numberOfPages-1{
            leftButton.isEnabled=true
            rightButton.isEnabled=false
        }else{
            leftButton.isEnabled=true
            rightButton.isEnabled=true
        }
        updateAyudaLabel()
    }
    
    func updateAyudaLabel(){
        guard let _ = ayudaLabel.text else { return }
        if !ayudaLabel.text!.isEmpty{
            ayudaLabel.text! = Constants.gamesDescription[pageControl.currentPage]
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        updateUI(for: page)
    }
    
    @objc func pageControlChanged() {
        scrollToPage(pageControl.currentPage)
    }

    @objc func nextPage() {
        let next = min(pageControl.currentPage + 1, imageNames.count - 1)
        scrollToPage(next)
    }

    @objc func prevPage() {
        let prev = max(pageControl.currentPage - 1, 0)
        scrollToPage(prev)
    }

    func scrollToPage(_ page: Int) {
        let offset = CGPoint(x: view.frame.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(offset, animated: true)
        updateUI(for: page)
    }
    
    func updateUI(for page: Int) {
        pageControl.currentPage = page
        updateNavigationButtonsState()
    }
    
    func pushToPokerGame(){
        let pokerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokerViewController") as! PokerViewController
        navigationController?.pushViewController(pokerViewController, animated: true)
    }
        
    func pushToTocameGame(){
        let tocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TocameViewController") as! TocameViewController
        navigationController?.pushViewController(tocameViewController, animated: true)
    }
    
    func pushToGeneralaGame(){
        let generalaViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GeneralaViewController") as! GeneralaViewController
        navigationController?.pushViewController(generalaViewController, animated: true)
    }
    
    func pushToPuntajeTocame(){
        let puntajeTocameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PuntajeTocameViewController") as! PuntajeTocameViewController
        Task{
            if let token = UserDefaults.standard.string(forKey: "Token"), let id = UserDefaults.standard.string(forKey: "Id"){
                puntajeTocameViewController.puntajes = await ScoreService().getMyListOfScoreService(id: id, token: token)
            }
            puntajeTocameViewController.modalPresentationStyle = .automatic
            puntajeTocameViewController.modalTransitionStyle = .coverVertical
            present(puntajeTocameViewController, animated: true, completion: nil)
        }
    }
    
    @objc func jugarButtonAction(){
        switch (pageControl.currentPage){
        case 0: pushToPokerGame()
        case 1: pushToTocameGame()
        default: pushToGeneralaGame()
        }
    }
    
    @objc func misPuntajesButtonAction(){
        pushToPuntajeTocame()
    }
    
    @objc func ayudaButtonAction(){
        if ayudaLabel.text!.isEmpty{
            ayudaLabel.text!=Constants.gamesDescription[pageControl.currentPage]
        }else{
            ayudaLabel.text! = ""
        }
    }
}

