//
//  ActivityIndicator.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 06/07/2022.
//

import Foundation
import Lottie

class ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    var animationView : AnimationView?
    
    private init() {}
    
    func activityIndicator()-> AnimationView {
        animationView = AnimationView(name: "pawLoading")
        animationView!.loopMode = .loop
        animationView?.backgroundColor = .clear
        animationView!.contentMode = .scaleAspectFit
        return animationView!
    }
    
    // we can pass enum instead of string
    func animatedView(animaitonName : String)-> AnimationView {
        animationView = AnimationView(name: animaitonName)
        animationView!.loopMode = .playOnce
        animationView?.animationSpeed = 1.5
        animationView?.contentMode = .scaleAspectFit
        animationView?.backgroundColor = .clear
        animationView!.play()
        return animationView!
    }
    
}

