//
//  MatchesMessagesController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/9/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools


class MatchesMessagesController: UICollectionViewController {
    
    let customNavBar: UIView = {
        let navBar = UIView()
        let iconImageView = UIImageView(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        iconImageView.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        let messageLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), textAlignment: .center)
        navBar.backgroundColor = .white
        navBar.setupShadow(opacity: 0.5, radius: 8, offset: .init(width: 0, height: 10), color: .init(white: 0, alpha: 0.5))
        let feedLabel = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), textAlignment: .center)
        navBar.stack(iconImageView.withHeight(44),
                     navBar.hstack(messageLabel, feedLabel, distribution: .fillEqually))
        
        return navBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
    }
}


