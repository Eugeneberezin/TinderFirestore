//
//  CardViewModel.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit
import LBTATools


protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    // we'll define the properties that are view will display/render out
    let uid: String
    let imageUrls: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(uid: String, imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.uid = uid
        self.imageUrls = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageUrl = imageUrls[imageIndex]
          //  let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, imageUrl)
            
            
        }
    }
    
    //Reactive programming
    var imageIndexObserver: ((Int, String?) ->())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageUrls.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
