//
//  FirestoreManager.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 10/07/2022.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    //MARK: - Creating a user entry in firestore database
    func createUser(for user : User, completion : @escaping (Bool)->()) {
        
        // Checking on the registration email existence
        isUserExists(user: user) { [weak self] exists in
            guard !exists else {
                completion(false)
                return
            }
            // Registration email entry does not exist
            self?.db.collection("users").addDocument(data: ["firstname" : user.firstName ,"joinDate" : user.joinDate, "lastname": user.lastName , "email" : user.email , "userId": user.userId]) { error  in
                guard error == nil else {
                    completion(false)
                    return
                }
                //Firestore entry success
                AuthManager.shared.creatAuthUser(user: user) { success in
                    guard success == true else {
                        return
                    }
                    // Auth User created
                    AuthManager.shared.loginUser(email: user.email, password: user.password) { success in
                        guard success == true else {
                            return
                        }
                        UserDefaults.standard.setValue(user.firstName, forKey: userDefaultsValues.firstname.rawValue)
                        UserDefaults.standard.setValue(user.lastName, forKey: userDefaultsValues.lastname.rawValue)
                        completion(true)
                    }
                }
            }
        }
    }
    
    //MARK: - Check if user entry exists in firestore database
    func isUserExists(user : User, completion: @escaping (Bool)->()) {
        
        db.collection("users").getDocuments { snapShot , error in
            guard error == nil , let docs = snapShot?.documents else {
                return
            }
            if (docs.contains { document in
                document["email"] as? String ?? "" == user.email
            }) {
                // user with this email already exists !
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
    
    //MARK: - Check if email exists in firestore database
    func isEmailExists(email : String, completion: @escaping (Bool)->()) {
        
        db.collection("users").getDocuments { snapShot , error in
            guard error == nil , let docs = snapShot?.documents else {
                return
            }
            if (docs.contains { document in
                document["email"] as? String ?? "" == email
            }) {
                // user with this email already exists !
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
    
}
