//
//  LoginViewController.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - IBoutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    private var viewModel: LoginViewModel
    
    //MARK: - Inits
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        findToken()
        setObservers()
    }
    
    //MARK: - IBAction
    @IBAction func onLoginButtonTap(_ sender: Any) {
        viewModel.onLoginButton(email: emailTextField.text, password: passwordTextField.text)
    }
}

//MARK: - EXTENSION
extension LoginViewController {
    //Metodo para "escuchar" variable de estado del viewModel
    private func setObservers() {
        viewModel.loginViewState = { [weak self] status in
            switch status {
                
            case .loading(let isLoading):
                self?.loadingView.isHidden = !isLoading
                
            case .loaded:
                self?.loadingView.isHidden = true
                self?.navigateToHome()
                
            case .showErrorEmail(let error):
                self?.errorEmail.text = error
                self?.errorEmail.isHidden = (error == nil || error?.isEmpty == true)
                
            case .showErrorPassword(let error):
                self?.errorPassword.text = error
                self?.errorPassword.isHidden = (error == nil || error?.isEmpty == true)
                
            case .errorNetwork(let errorMessage):
                self?.loadingView.isHidden = true
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    //MARK: - Navigate
    private func navigateToHome() {
        let nextVM = HomeViewModel(homeUseCase: HomeUseCase())
        let nextVC = HomeTableViewController(homeViewModel: nextVM)
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    //MARK: - Alert
    private func showAlert(message: String){
        let alertControler = UIAlertController(title: "ERROR NETWORK", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertControler.addAction(okAction)
        present(alertControler, animated: true, completion: nil)
    }
}

extension LoginViewController {
    func findToken(){
        guard let _ = UserDefaultsHelper.getToken() else {
           print("No existe token")
            return
        }
         navigateToHome()
    }
}
