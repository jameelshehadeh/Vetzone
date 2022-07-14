//
//  HomeViewController.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 02/07/2022.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var viewModel : HomeViewViewModel = {
        return HomeViewViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        AuthManager.shared.logoutUser { [weak self] success in
            guard success == true else {
                return
            }
            guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") else {return}
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
        
}
