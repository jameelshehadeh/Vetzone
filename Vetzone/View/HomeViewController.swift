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
            self?.dismiss(animated: true)
        }
    }
    
        
}
