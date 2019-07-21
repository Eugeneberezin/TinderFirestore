//
//  User.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/19/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit

struct User: ProducesCardViewModel {
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageName: imageName, attributedString: attributedText , textAlighment: .left)
    }
}


