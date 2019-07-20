//
//  ViewController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    //hader
    let topStackView = TopNavigationStackView()
    let buttonsStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()
    
    
    
    let cardViewModels = [User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c" ).toCardViewModel(),
    User(name: "Eugene", age: 33, profession: "iOS Dev", imageName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE" ).toCardViewModel(),
    User(name: "Jill", age: 18, profession: "Teacher", imageName: "lady4c" ).toCardViewModel()
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsStackView.distribution = .fillEqually
        setUpLayout()
        setUpDummyCards()
    }
    
    fileprivate func setUpDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedString
            cardView.informationLabel.textAlignment = cardVM.textAlighment
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
            
            
        }

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

