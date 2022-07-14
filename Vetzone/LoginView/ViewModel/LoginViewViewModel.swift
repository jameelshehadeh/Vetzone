//
//  LoginViewViewModel.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 02/07/2022.
//

import Foundation

class LoginViewViewModel {
    
    var isSignedIn : Observable<Bool> = Observable(false)
    
    //Check if user already is signed in
    func checkUserAuthStatus(){
        guard let _ = UserDefaults.standard.value(forKey: "email") as? String, AuthManager.shared.authUserStatus() == true else {
            isSignedIn.value = false
            return
        }
        isSignedIn.value = true
    }
    
    //Sign the user in
    func loginUser(email: String, password: String, completion: @escaping (Bool)->()) {
        AuthManager.shared.loginUser(email: email, password: password) { [weak self] success in
            guard success == true else {
                completion(false)
                return
            }
            self?.isSignedIn.value = success
            UserDefaults.standard.set(email, forKey: "email")
            completion(success)
        }
    }
    
}
