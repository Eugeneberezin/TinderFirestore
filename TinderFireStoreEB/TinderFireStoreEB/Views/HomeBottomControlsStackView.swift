//
//  HomeBottomControlsStackView.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/17/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import LBTATools

class HomeBottomControlsStackView: UIStackView {
    
    static func createButton(image: UIImage, accessibilityID: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.accessibilityIdentifier = accessibilityID
        return button
    }
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"), accessibilityID: "REFRESH_BUTTON")
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"), accessibilityID: "DISLIKE_BUTTON")
    //let starButton = createButton(image: #imageLiteral(resourceName: "super_like_circle"), accessibilityID: "STAR_BUTTON")
    let likeButton = createButton(image: #imageLiteral(resourceName: "like_circle"), accessibilityID: "FAVORITE_BUTTON")
    //let boostButton = createButton(image: #imageLiteral(resourceName: "boost_circle"), accessibilityID: "BOOST_BUTTON")

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        [dislikeButton, refreshButton, likeButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
        
        refreshButton.accessibilityIdentifier = "REFRESH_BUTTON"
        dislikeButton.accessibilityIdentifier = "DISLIKE_BUTTON"
       // starButton.accessibilityIdentifier = "STAR_BUTTON"
        likeButton.accessibilityIdentifier = "HEART_BUTTON"
       // boostButton.accessibilityIdentifier = "BOOST_BUTTON"
        
        
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
