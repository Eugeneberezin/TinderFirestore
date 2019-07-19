//
//  HomeBottomControlsStackView.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/17/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let subViews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            button.isAccessibilityElement = true
            return button
        }
        
        subViews[0].accessibilityIdentifier = "REFRESH_BUTTON"
        subViews[1].accessibilityIdentifier = "X_BUTTON"
        subViews[2].accessibilityIdentifier = "STAR_BUTTON"
        subViews[3].accessibilityIdentifier = "HEART_BUTTON"
        subViews[4].accessibilityIdentifier = "BOOST_BUTTON"
        
        
    
        subViews.forEach { (v) in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
