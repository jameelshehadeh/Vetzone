//
//  Validation.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 06/07/2022.
//

import Foundation

class Validation {
    
    static let shared = Validation()
    
    private init () {}
    
    //Validates password and email entry
    func isEmailAndpasswordValid(email: String , password: String) -> Bool {
        guard email.contains("@") , email.contains(".") , !email.isEmpty , !password.isEmpty , password.count >= 8  else {
            return false
        }
        return true
    }
    
    //Validates name entry
    func isNameValid(for name: String)-> Bool {
        //Name should not contain numbers
        // write the logic here
        return true
    }
    
    func isRegistrationEntryValid(firstname: String , lastname: String, email: String, password: String)->Bool {
        
        guard firstname.isValidNameValue() , lastname.isValidNameValue() , !lastname.isEmpty , !firstname.isEmpty , !email.isEmpty , email.contains("@") , email.contains("."), password.count >= 8 , !password.contains(" ") else {
            return false
        }
        return true
    }
    

}
