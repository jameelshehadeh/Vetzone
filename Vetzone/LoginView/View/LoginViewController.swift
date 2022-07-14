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
    
    lazy var activityIndicator = ActivityIndicator.shared.activityIndicator()
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    private func configureUI(){
        loginButton.layer.cornerRadius = 8
        logoImageView.clipsToBounds = true
    }
    
    private func setupBindings() {
        viewModel.isSignedIn.bind({[weak self] success in
            guard success == true else {
                return
            }
            self?.goToHomeScreen()
        })
        viewModel.checkUserAuthStatus()
    }
    
    private func goToHomeScreen() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: Constants.mainTabBarController) else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    func addAnimation(){
        logoImageView.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0 , y: 0 , width: logoImageView.frame.width, height: logoImageView.frame.height)
        activityIndicator.play()
        view.alpha = 0.9
        logoImageView.image = nil
    }
    
    private func goToAdminApp(){
        
    }
    
    @IBAction func loginUserPressed(_ sender: UIButton) {
        
        // password and email validation code
        guard let email = emailTextField.text , let password = passwordTextField.text, Validation.shared.isEmailAndpasswordValid(email: email, password: password) else {
            return
        }
        addAnimation()
        viewModel.loginUser(email: email, password: password) {[weak self] success in
            guard success == true else {
                self?.activityIndicator.stop()
                self?.activityIndicator.removeFromSuperview()
                self?.logoImageView.image = UIImage(named: Constants.brandLogo)
                self?.view.alpha = 1.0
                return
            }
            self?.activityIndicator.removeFromSuperview()
            self?.view.alpha = 1.0
            self?.activityIndicator.stop()
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        
    }
    
}
