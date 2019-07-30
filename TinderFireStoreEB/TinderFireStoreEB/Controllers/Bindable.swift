//
//  Bindable.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/29/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
