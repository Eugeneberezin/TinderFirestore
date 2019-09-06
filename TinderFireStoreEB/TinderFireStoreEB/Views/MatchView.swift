//
//  MatchView.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/3/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import Firebase

class MatchView: UIView {
    
    var cardUID: String! {
        didSet {
            let query = Firestore.firestore().collection("users")
            query.document(cardUID).getDocument { (snapshot, err) in
                if let err = err {
                    print("ERROR GETTING CARDUID ON MATCHVIEW>>>  ",err )
                    return
                }
                guard let dictionary = snapshot?.data() else { return }
                let cardUser = User(dictionary: dictionary)
                guard let url = URL(string: cardUser.imageUrl1 ?? "") else { return }
                self.cardUserImageView.sd_setImage(with: url)
                self.descriptionLabel.text = "You and \(cardUser.name ?? "") have\nswiped right each other "
            }
            
            Firestore.firestore().fetchCurrentUser { (user, err) in
                if let err = err {
                    print(err)
                    return
                }
                
                guard let url = URL(string: user?.imageUrl1 ?? "")  else { return }
                self.currentUserImageView.sd_setImage(with: url)
            }
            
        }
    }
    
    fileprivate let itsAMatchView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You and X have swiped\nright each other"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let currentUserImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "jane3"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
        
    }()
    
    fileprivate let sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        return button
        
    }()
    
    fileprivate let keetSwipingButton: UIButton = {
        let button = KeepSwipingButton(type: .system)
        button.setTitle("Keep swiping", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        return button
    }()
    
    fileprivate let cardUserImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBlurView()
        setupLayout()
        setupAnimations()
    }
    
    
    fileprivate func  setupAnimations() {
        //starting positions
        let angle = -30 * CGFloat.pi / 180
        currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 0, y: 500))
        cardUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating( CGAffineTransform(translationX: 0, y: -500))
        // keyframe animations for segmented animations
        
        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: .calculationModeCubic, animations: {
            //animation1
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45, animations: {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.cardUserImageView.transform = CGAffineTransform(rotationAngle: angle)
            })
            //animation2
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.3, animations: {
                self.currentUserImageView.transform = .identity
                self.cardUserImageView.transform = .identity
                
            })
            
        }) { (_) in
            
        }
        
        sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
        keetSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)
        
        UIView.animate(withDuration: 1.5, delay: 0.6, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.sendMessageButton.transform = .identity
            self.keetSwipingButton.transform = .identity
        }) { (_) in
            
        }
//        UIView.animate(withDuration: 1.6, animations: {
//        self.sendMessageButton.transform = .identity
//        self.keetSwipingButton.transform = .identity
//
//
//        }) { (_) in
//
//        }
    }
    
    let size: CGFloat  = 140
    
    fileprivate func setupLayout() {
        addSubview(itsAMatchView)
        addSubview(descriptionLabel)
        addSubview(currentUserImageView)
        addSubview(cardUserImageView)
        addSubview(sendMessageButton)
        addSubview(keetSwipingButton)
        
        
        itsAMatchView.anchor(top: nil, leading: nil, bottom: descriptionLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 300, height: 80))
        itsAMatchView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        descriptionLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: currentUserImageView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 32, right: 0), size: .init(width: 0, height: 50))
        
        
        currentUserImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: size, height: size))
        currentUserImageView.layer.cornerRadius = 140 / 2
        currentUserImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        cardUserImageView.anchor(top: nil, leading: centerXAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: size, height: size))
        cardUserImageView.layer.cornerRadius = 140 / 2
        cardUserImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 48, bottom: 0, right: 48), size: .init(width: 0, height: 60))
        
        keetSwipingButton.anchor(top: sendMessageButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 48, bottom: 0, right: 48), size: .init(width: 0, height: 60))
        
        
    }
    
    fileprivate let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate func setupBlurView() {
        
        
        visualEffect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        addSubview(visualEffect)
        visualEffect.fillSuperview()
        
        visualEffect.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffect.alpha = 1
        }) { (_) in
            
        }
    }
    
    @objc fileprivate func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
           self.removeFromSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
