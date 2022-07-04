//
//  Observable.swift
//  Vetzone
//
//  Created by Jameel Shehadeh on 02/07/2022.
//

import Foundation

final class Observable<T> {
 
    var value : T {
        didSet {
            // we initialize the value
            //  we properly got access to our listener BUT we dont send any notification
            // when changes occur so if any changes happens to our value object we dont know !
            // so we need to implement didSet property
            listener?(value)
        }
    }
    
    private var listener : ((T) -> Void)?
    
    init(_ value : T) {
        self.value = value
    }
    
    // this function will allow views to subscribe to a particular ViewModel
    // contains a closure that will inform who ever subscribe/listening that something happened or changed
    func bind(_ listener : @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
