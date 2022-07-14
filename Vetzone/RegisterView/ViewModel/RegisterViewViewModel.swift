//
//  RegisterViewViewModel.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 08/07/2022.
//

import Foundation
import FirebaseAuth

struct RegisterViewViewModel {
    
    var user : Observable<User?> = Observable(nil)
    
    //MARK: - Registering a new user
    func registerUser(for user: User? , completion : @escaping (Bool)->()) {
        
        guard let registeredUser = user else {
            completion(false)
            return
        }
        
        // create user
        FirestoreManager.shared.createUser(for: registeredUser) { success in
            guard success == true else {
                completion(false)
                return
            }
            completion(true)
            // user created
            self.user.value = registeredUser
        }
    }
    
}
