//
//  MatchesNavBar.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/10/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import LBTATools

class MatchesNavBar: UIView {
    
    let backButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), tintColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let iconImageView = UIImageView(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        iconImageView.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        let messageLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), textAlignment: .center)
        backgroundColor = .white
        setupShadow(opacity: 0.5, radius: 8, offset: .init(width: 0, height: 10), color: .init(white: 0, alpha: 0.5))
        let feedLabel = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), textAlignment: .center)
        stack(iconImageView.withHeight(44),
                     hstack(messageLabel, feedLabel, distribution: .fillEqually))
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 8, bottom: 0, right: 0), size: .init(width: 38, height: 38))
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

