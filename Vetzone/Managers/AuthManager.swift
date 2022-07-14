//
//  AuthManager.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 03/07/2022.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init () {}
    
    //MARK: - Create Auth User
    func creatAuthUser(user: User , completion : @escaping(Bool)->()){
        Auth.auth().createUser(withEmail: user.email, password: user.password) { _ , error in
            guard error == nil else {
                completion(false)
                return
            }
            // auth user created
            completion(true)
        }
    }
    
    //MARK: - Checking Auth User status
    func authUserStatus() -> Bool {
        guard Auth.auth().currentUser?.email != nil else {
            return false
        }
        return true
    }
    
    //MARK: - SignIn Auth User
    func loginUser(email: String, password: String, completion: @escaping (Bool)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
            UserDefaults.standard.setValue(email, forKey: "email")
        }
    }
    
    //MARK: - Logout Current Auth User
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
    
    //MARK: - Send Password reset email
    func resetPassword(for email: String, completion: @escaping(Bool)->()){
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                completion(false)
                return
            }
            // Password reset email sent
            completion(true)
        }
        
    }
    
    
}
