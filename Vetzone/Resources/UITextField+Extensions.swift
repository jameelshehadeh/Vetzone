//
//  UITextField+Extensions.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 05/07/2022.
//

import Foundation
import UIKit

 var eyeButton = UIButton()

extension UITextField  {
    
    func addEyeToggle(){
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.addTarget(self, action: #selector(didTapToggle), for: .touchUpInside)
        var buttonConfig = UIButton.Configuration.bordered()
        buttonConfig.baseBackgroundColor = .clear
        eyeButton.configuration = buttonConfig
        rightViewMode = .always
        rightView = eyeButton
    }
    
    @objc func didTapToggle(){
        
        guard text?.count != 0 else {
            return
        }
        
        isSecureTextEntry.toggle()
        
        guard isSecureTextEntry else {
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            isSecureTextEntry = false
            return
        }
        
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        isSecureTextEntry = true
    }
        
}
