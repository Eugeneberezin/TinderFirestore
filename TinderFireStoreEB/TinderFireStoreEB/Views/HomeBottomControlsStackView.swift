//
//  HomeBottomControlsStackView.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/17/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
    let starButton = createButton(image: #imageLiteral(resourceName: "super_like_circle"))
    let favoriteButton = createButton(image: #imageLiteral(resourceName: "like_circle"))
    let boostButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        [refreshButton, dislikeButton, starButton, favoriteButton, boostButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
        
        refreshButton.accessibilityIdentifier = "REFRESH_BUTTON"
        dislikeButton.accessibilityIdentifier = "DISLIKE_BUTTON"
        starButton.accessibilityIdentifier = "STAR_BUTTON"
        favoriteButton.accessibilityIdentifier = "HEART_BUTTON"
        boostButton.accessibilityIdentifier = "BOOST_BUTTON"
        
        
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
