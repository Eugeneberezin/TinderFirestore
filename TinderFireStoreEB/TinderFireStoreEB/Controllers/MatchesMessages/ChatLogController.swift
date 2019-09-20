//
//  ChatLogController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/13/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools

struct Message {
    let text: String
    let isFromCurrentLoggedUser: Bool
}

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


class ChatLogController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout {
    
    fileprivate lazy var customNavBar = MessageNavBar(match: self.match)
    fileprivate let match: Match
    
    init(match: Match){
        self.match = match
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    lazy var redView: UIView = {
        return CustomInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return redView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.alwaysBounceVertical = true
        items = [
            .init(text: "Hello Eugene test, user, He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction. He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.He called for checks to discover whether corrupt officials are being bribed to connive in shoddy construction.", isFromCurrentLoggedUser: false),
            .init(text: "Hello Eugene", isFromCurrentLoggedUser: true),
            .init(text: "Hello Eugene", isFromCurrentLoggedUser: true),
            .init(text: "Hello Eugene", isFromCurrentLoggedUser: false)
        ]
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 120))
        collectionView.contentInset.top = 120
        collectionView.scrollIndicatorInsets.top = 120
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //estimated sizing
        let estimatedSizeCell = MessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
       estimatedSizeCell.item = self.items[indexPath.item]
       estimatedSizeCell.layoutIfNeeded()
       let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}


