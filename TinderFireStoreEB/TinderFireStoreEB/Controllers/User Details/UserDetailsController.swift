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
            swipingPhotosController.cardViewModel = cardViewModel
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
        
    }()
    
    fileprivate let swipingPhotosController = SwipingPhotosController(isCardViewMode: false)
    

    fileprivate let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Eugene 30\niOSDev\nPlaceholder bio"
        label.numberOfLines = 0
        label.accessibilityIdentifier = "USER_INFO_TEXT"
        return label
    }()
    
    fileprivate let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "profileIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.accessibilityIdentifier = "DISMISS_BUTTON"
        button.accessibilityLabel = "Dismiss"
        button.accessibilityHint = "Double tap to dismiss"
        button.addTarget(self, action: #selector(handleTapDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var dislikeButton = self.createButton(image: #imageLiteral(resourceName: "dismiss_circle"), selector: #selector(handleDislike), accessibilityID: "Dislike")
    lazy var superLikeButton = self.createButton(image: #imageLiteral(resourceName: "super_like_circle"), selector: #selector(handleDislike), accessibilityID: "SUPERLIKE")
    lazy var likeButton = self.createButton(image: #imageLiteral(resourceName: "like_circle"), selector: #selector(handleDislike), accessibilityID: "LIKE")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    fileprivate let extrtaSwipingHeight: CGFloat = 80
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let imageView = swipingPhotosController.view!
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + extrtaSwipingHeight)
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
        visualEffectView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
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
        
        let swipingView = swipingPhotosController.view!
        
        scrollView.addSubview(swipingView)
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: swipingView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        scrollView.addSubview(dismissButton)
        dismissButton.anchor(top: swipingView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: -25, left: 0, bottom: 0, right: 25), size: .init(width: 50, height: 50))
        setupVisualBlurEffectView()
        setUpBottomControlors()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let imageView = swipingPhotosController.view!
        let changeY = -scrollView.contentOffset.y
        var width = view.frame.width + changeY * 2
        width = max(view.frame.width, width)
        imageView.frame = CGRect(x: min(0, -changeY), y: min(0, -changeY), width: width, height: width + extrtaSwipingHeight)
    }
    
    
    
    fileprivate func dismissUserDetailsController() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.dismiss(animated: true)
    }
    


}
