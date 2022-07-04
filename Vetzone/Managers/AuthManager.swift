//
//  AuthManager.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 03/07/2022.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    private init () {}
    
    //Sign in the user
    func loginUser(email: String, password: String, completion: @escaping (Bool)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    //Check user authentication status
    func userAuthStatus() -> Bool {
        guard Auth.auth().currentUser?.email != nil else {
            return false
        }
        return true
    }
    
    //Logout current user
    func logoutUser(completion: @escaping (Bool)->()) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "email")
            completion(true)
        }
        catch {
            completion(false)
            print("error signing out \(error)")
        }
    }
}
