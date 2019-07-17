//
//  ViewController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let subViews = [UIColor.gray, UIColor.darkGray, UIColor.black].map {
            (color) -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
            
        }
        
        let topStackView = UIStackView(arrangedSubviews: subViews)
        
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let yellowViw = UIView()
        yellowViw.backgroundColor = .yellow
        yellowViw.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, blueView, yellowViw])
        //stackView.distribution = .fillEqually
        stackView.axis = .vertical
        view.addSubview(stackView)
       
        
        
        stackView.fillSuperview()
        
        //autolayout
       
        
        
        
    }


}

