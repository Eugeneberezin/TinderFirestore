//
//  CustomInputAccessoryView.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools

//input accessery view
class CustomInputAccessoryView: UIView {
    let textView = UITextView()
    let sendButton = UIButton(title: "Send", titleColor: .black, font: .boldSystemFont(ofSize: 16), target: nil, action: nil)
    let placeholderLabel = UILabel(text: "Enter Message",  textColor: .lightGray)
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupShadow(opacity: 0.1, radius: 8, offset: .init(width: 0, height: -8), color: .black)
        autoresizingMask = .flexibleHeight
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 16)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
        hstack(textView,
               sendButton.withSize(.init(width: 60, height: 60)),
               alignment: .center).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: sendButton.leadingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        placeholderLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor).isActive = true
        
        
        //        let stackView = UIStackView(arrangedSubviews: [textView, sendButton])
        //        stackView.alignment = .center
        //        sendButton.constrainHeight(60)
        //        sendButton.constrainWidth(60)
        //        redView.addSubview(stackView)
        //        stackView.fillSuperview()
        //        stackView.isLayoutMarginsRelativeArrangement = true
        
        
        
    }
    
    @objc fileprivate func handleTextChange() {
        placeholderLabel.isHidden = textView.text.count != 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
