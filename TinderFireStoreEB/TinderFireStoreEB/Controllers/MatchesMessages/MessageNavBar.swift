//
//  MessageNavBar.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/13/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools

class MessageNavBar: UIView {
    let userProfileImageView = UIImageView(image: #imageLiteral(resourceName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "User Name", font: .systemFont(ofSize: 16))
    
    let messageBackButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), tintColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), target: self, action: #selector(handleBack))
    let flagButton = UIButton(image: #imageLiteral(resourceName: "flag").withRenderingMode(.alwaysOriginal), tintColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
    
    fileprivate let match: Match
    
    init(match: Match) {
        self.match = match
        super.init(frame: .zero)
        backgroundColor = .white
        nameLabel.text = match.name
        userProfileImageView.sd_setImage(with: URL(string: match.profileImageUrl))
        
        setupShadow(opacity: 0.5, radius: 8, offset: .init(width: 0, height: 10), color: .init(white: 0, alpha: 0.5))
        userProfileImageView.constrainWidth(44)
        userProfileImageView.constrainHeight(44)
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.cornerRadius = 44 / 2
        
        
        let middleStack = hstack(
            stack(
                userProfileImageView,
                nameLabel,
                spacing: 8,
                alignment: .center),
            alignment: .center
        )
        
        hstack(messageBackButton.withWidth(50),
               middleStack,
               flagButton).withMargins(.init(top: 0, left: 4, bottom: 0, right: 16))
        
        
    }
    
    @objc func handleBack() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

