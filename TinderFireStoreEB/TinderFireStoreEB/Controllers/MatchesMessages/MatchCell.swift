//
//  MatchCell.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools

class MatchCell: LBTAListCell<Match> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Username here", font: .systemFont(ofSize: 14, weight: .bold), textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1) , textAlignment: .center, numberOfLines: 2)
    
    override var item: Match! {
        didSet {
            usernameLabel.text = item.name
            profileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        profileImageView.clipsToBounds = true
        profileImageView.constrainWidth(80)
        profileImageView.constrainHeight(80)
        profileImageView.layer.cornerRadius = 80 / 2
        stack(stack(profileImageView, alignment: .center),
              usernameLabel)
        
    }
    
}


