//
//  String + Extensions.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 11/07/2022.
//

import Foundation

extension String {
    
    func isValidNameValue()->Bool{
        guard (!self.contains { char in !char.isLetter}) else {
            return false
        }
        return true
    }
    
}
