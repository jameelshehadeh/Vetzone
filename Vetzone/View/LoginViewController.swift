//
//  LoginViewController.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 02/07/2022.
//

import UIKit

class LoginViewController: UIViewController {

    lazy var viewModel : LoginViewViewModel = {
       return LoginViewViewModel()
    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    func configureUI(){
        loginButton.layer.cornerRadius = 8
    }
    
    func setupBindings() {
        viewModel.isSignedIn.bind({[weak self] success in
            guard success == true else {
                return
            }
            self?.goToHomeScreen()
        })
        viewModel.checkUserAuthStatus()
    }
    
    private func goToHomeScreen() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabbarController") else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func loginUserPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text , let password = passwordTextField.text else {
            return
        }
        viewModel.loginUser(email: email, password: password)
    }
}
