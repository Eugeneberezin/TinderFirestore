//
//  MessageCell.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import Firebase
import LBTATools

class MessageCell: LBTAListCell<Message> {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 20)
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
        
    }()
    
    let bubbleContainer = UIView(backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    override var item: Message! {
        didSet {
            textView.text = item.text
            
            if item.isFromCurrentLoggedUser {
                anchoredConstraints.trailing?.isActive = true
                anchoredConstraints.leading?.isActive = false
                bubbleContainer.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                textView.textColor = .white
            } else {
                anchoredConstraints.trailing?.isActive = false
                anchoredConstraints.leading?.isActive = true
                bubbleContainer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                textView.textColor = .black
                
            }
        }
    }
    
    var anchoredConstraints: AnchoredConstraints!
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(bubbleContainer)
        anchoredConstraints = bubbleContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        anchoredConstraints.leading?.constant = 20
        anchoredConstraints.trailing?.isActive = false
        anchoredConstraints.trailing?.constant = -20
        
        bubbleContainer.layer.cornerRadius = 15
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubbleContainer.addSubview(textView)
        textView.fillSuperview(padding: .init(top: 4, left: 12, bottom: 4, right: 12))
        
    }
    
}

