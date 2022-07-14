//
//  RegisterViewController.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 05/07/2022.
//

import UIKit
import Lottie
import SwiftUI

class RegisterViewController: UIViewController  {

    //RegisterButton
    @IBOutlet weak var registerButton: UIButton!
    
    //AnimationImageView
    @IBOutlet weak var animationImageView: UIImageView!
    
    //UITextFields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registrationInstructionsStackView: UIStackView!
    var activityIndicator = UIActivityIndicatorView()
    
    //viewModel
    lazy var viewModel : RegisterViewViewModel = {
        return RegisterViewViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimation()
    }
    
    func setupBindings(){
        viewModel.user.bind { [weak self] user in
            guard let _ = user else {
                return
            }
            //registeration successful
            self?.goToHomeScreen()
        }
    }
    
    private func goToHomeScreen() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: Constants.mainTabBarController) else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func configureUI(){
        //Delegates
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //password TextField
        passwordTextField.autocorrectionType = .no
        passwordTextField.addEyeToggle()
        
        //registerButton
        registerButton.layer.cornerRadius = 8
        
        //registration instructions
        registrationInstructionsStackView.arrangedSubviews.forEach { view in
            view.isHidden = true
        }
    }
    
    func addAnimation(){
        let animatedView = ActivityIndicator.shared.animatedView(animaitonName: "vetzoneServices")
        animationImageView.addSubview(animatedView)
        animationImageView.clipsToBounds = true
        animationImageView.contentMode = .scaleAspectFill
        animatedView.frame = animationImageView.bounds
    }
    
    func addActivityIndicator(){
        view.isUserInteractionEnabled = false
        registerButton.setTitle("", for: .normal)
        registerButton.alpha = 0.8
        registerButton.addSubview(activityIndicator)
        activityIndicator.frame = registerButton.bounds
        navigationController?.navigationBar.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func dismissActivityIndicator(){
        registerButton.alpha = 1
        registerButton.setTitle("Register", for: .normal)
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
    func StackViewVisibility(isHidden: Bool){
        registrationInstructionsStackView.arrangedSubviews.forEach { view in
            UIView.animate(withDuration: 1.0) {
                view.isHidden = isHidden
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        StackViewVisibility(isHidden: true)
        
        guard let firstName = firstNameTextField.text?.replacingOccurrences(of: " ", with: ""), let lastName = lastNameTextField.text?.replacingOccurrences(of: " ", with: ""),let email = emailTextField.text?.replacingOccurrences(of: " ", with: "") , let password = passwordTextField.text , Validation.shared.isRegistrationEntryValid(firstname: firstName , lastname: lastName, email: email, password: password) else {
            StackViewVisibility(isHidden: false)
            return
        }
        
        addActivityIndicator()
        // Registering user
        viewModel.registerUser(for: User(userId: UUID().uuidString, firstName: firstName, lastName: lastName, email: email, password: password, joinDate: Date.now)) {[weak self] success in
            guard success else {
                DispatchQueue.main.async {
                    self?.dismissActivityIndicator()
                    self?.view.isUserInteractionEnabled = true
                }
                return
            }
        }
    }
}

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == emailTextField {
            FirestoreManager.shared.isEmailExists(email: textField.text!) { [weak self] exists in
                if exists {
                    DispatchQueue.main.async {
                        self?.emailTextField.text = "Email already exists"
                        self?.emailTextField.textColor = .red
                        textField.resignFirstResponder()
                    }
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.text = nil
            emailTextField.textColor = .black
        }
    }
}
