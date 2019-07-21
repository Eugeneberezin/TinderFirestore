//
//  Advertiser.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/21/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit

struct Advertiser: ProducesCardViewModel {
    let title: String
    let brandName: String
    let postPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageName: postPhotoName, attributedString: attributedString, textAlighment: .center)
        
    }
}
