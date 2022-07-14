//
//  ForgotPasswordViewController.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 07/07/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        resetPasswordButton.layer.cornerRadius = 8
    }

    @IBAction func resetPasswordPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        AuthManager.shared.resetPassword(for: email) { [weak self] success  in
            guard let self = self else {
                return
            }
            guard success else {
                Alerts.shared.showAlert(in: self, alertTitle: "Error", alertMessage: "Error sending password reset email", alertStyle: .alert)
                return
            }
            Alerts.shared.showAlert(in: self, alertTitle: "Email sent!", alertMessage: "Please check your email for your password reset instructions.", alertStyle: .alert)
        }
        
    }
    
    @IBAction func dismissPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
