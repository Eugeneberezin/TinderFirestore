//
//  ViewController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 8/13/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class UserDetailsController: UIViewController, UIScrollViewDelegate {
    
    var cardViewModel: CardViewModel! {
        didSet {
            infoLabel.attributedText = cardViewModel.attributedString
            
            guard let firstImageUrl = cardViewModel.imageUrls.first, let url = URL(string: firstImageUrl) else { return }
            imageView.sd_setImage(with: url)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
        
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.accessibilityIdentifier = "USER_PHOTO"
        return iv
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Eugene 30\niOSDev\nPlaceholder bio"
        label.numberOfLines = 0
        label.accessibilityIdentifier = "USER_INFO_TEXT"
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "profileIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.accessibilityIdentifier = "DISMISS_BUTTON"
        button.accessibilityLabel = "Dismiss"
        button.accessibilityHint = "Double tap to dismiss"
        button.addTarget(self, action: #selector(handleTapDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var dislikeButton = self.createButton(image: #imageLiteral(resourceName: "dismiss_circle"), selector: #selector(handleDislike), accessibilityID: "Dislike button")
    lazy var superLikeButton = self.createButton(image: #imageLiteral(resourceName: "super_like_circle"), selector: #selector(handleDislike), accessibilityID: "SUPERLIKE BUTTON")
    lazy var likeButton = self.createButton(image: #imageLiteral(resourceName: "like_circle"), selector: #selector(handleDislike), accessibilityID: "LIKE BUTTON")
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        
    }
    
    @objc fileprivate func handleDislike() {
        print("Handle dislike")
    }
    
    fileprivate func setUpBottomControlors() {
        let buttonStackView = UIStackView(arrangedSubviews: [dislikeButton, superLikeButton, likeButton])
        buttonStackView.distribution = .fillEqually
        view.addSubview(buttonStackView)
        buttonStackView.axis = .horizontal
        buttonStackView.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 50, right: 0))
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupVisualBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, leading: imageView.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: imageView.trailingAnchor)
    }
    
    fileprivate func createButton(image:UIImage, selector: Selector, accessibilityID: String) -> UIButton{
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.accessibilityLabel = accessibilityID
        return button
    }
    
    fileprivate func setUpLayout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        scrollView.addSubview(imageView)
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: imageView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        scrollView.addSubview(dismissButton)
        dismissButton.anchor(top: imageView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: -25, left: 0, bottom: 0, right: 25), size: .init(width: 50, height: 50))
        setupVisualBlurEffectView()
        setUpBottomControlors()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        var width = view.frame.width + changeY * 2
        width = max(view.frame.width, width)
        imageView.frame = CGRect(x: min(0, -changeY), y: min(0, -changeY), width: width, height: width)
    }
    
    
    
    fileprivate func dismissUserDetailsController() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.dismiss(animated: true)
    }
    


}
