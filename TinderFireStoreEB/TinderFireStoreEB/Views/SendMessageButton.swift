//
//  SendMessageButton.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/4/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import LBTATools

class SendMessageButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        let leftColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        let rightColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.6)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.6)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = rect
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
        
        
    }

}
