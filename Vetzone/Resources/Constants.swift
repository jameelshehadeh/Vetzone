//
//  Constants.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 11/07/2022.
//

import Foundation

struct Constants {
    
    private init () {}
    
    //App colors
    static let brandColor = "brandColor"
    static let brandLogo = "vetzoneLogo"
    
    //Storyboard identifiers
    static let mainTabBarController = "MainTabbarController"

}

//User defaults
enum userDefaultsValues : String {
    case email = "email"
    case firstname = "firstname"
    case lastname = "lastname"
}
