//
//  HomeTableViewController.swift
//  DragonBallMVVM
//
//  Created by Aitor Iglesias Pubill on 22/1/24.
//

import UIKit

class HomeTableViewController: UIViewController {
//    typealias DataSource = UITableViewDiffableDataSource<Int,HeroModel>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, HeroModel>
    
    //IBOutlets
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var LogOutButton: UIButton!
    
    //ViewModel
    private var homeViewModel: HomeViewModel
//    private var dataSource: DataSource?
    
    //Init
    init(homeViewModel: HomeViewModel = HomeViewModel()){
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        tableViewOutlet.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCell")
        homeViewModel.loadHeros()
        setObservers()
        
        // MARK: CELDA CUSTOM
        // registro la clase de la celda personalizada
        tableViewOutlet.register(
            UINib(nibName: CellCustomTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CellCustomTableViewCell.identifier)
        
    }
    
    private func setObservers(){
        homeViewModel.homeStatusLoad = { [weak self] status in
            switch status{
            case .loading:
                print("Home Loading")
            case .loaded:
                self?.tableViewOutlet.reloadData()

            case .error:
                print("home error")
            case .none:
                print("home none")
            }
        }
    }
    
    //MARK: Navigation LogOut
   
    @IBAction func LogOutButton(_ sender: Any) {
    UserDefaultsHelper.deleteToken()
        let nextVC = LoginViewController()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    
}

//MARK: - Extension Delegate para temas de navegación
extension HomeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = homeViewModel.dataHeroes[indexPath.row].name
        let detailViewController = DetailViewController(heroe: name)
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

//MARK: - Extesion DataSource
extension HomeTableViewController: UITableViewDataSource {
    //Numero de columnas por seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.dataHeroes.count
    }
    //Formato de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellCustomTableViewCell.identifier,
                                                 for: indexPath) as! CellCustomTableViewCell
        // Le paso a la celda el index del personaje
        cell.configure(with: homeViewModel.dataHeroes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Devuelve la altura deseada para la celda en indexPath
        135
    }
}

