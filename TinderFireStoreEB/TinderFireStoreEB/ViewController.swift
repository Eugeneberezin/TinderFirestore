//
//  ViewController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //hader
    let topStackView = TopNavigationStackView()
    let buttonsStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()

    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsStackView.distribution = .fillEqually
        setUpLayout()
        setUpDummyCards()
    }
    
    fileprivate func setUpDummyCards() {
        let cardView = CardView()
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
        
    }
    
    // MARK:- Filterprivate
    
    fileprivate func setUpLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        
        
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
    }


}

