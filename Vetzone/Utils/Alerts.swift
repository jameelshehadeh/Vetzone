//
//  Alerts.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 11/07/2022.
//

import Foundation
import UIKit

final class Alerts {
    
    static let shared = Alerts()
    
    private init () {}
    
    func showAlert(in vc: UIViewController , alertTitle : String , alertMessage: String, alertStyle: UIAlertController.Style){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let alertAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
    
}
