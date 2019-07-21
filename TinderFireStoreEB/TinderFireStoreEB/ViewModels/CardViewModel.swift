//
//  CardViewModel.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit


protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    
    let imageName: String
    let attributedString : NSAttributedString
    let textAlighment: NSTextAlignment
    
}
