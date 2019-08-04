//
//  ViewController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    //hader
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
    
    var cardViewModels = [CardViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        setupLayout()
        setupFirestoreUserCards()
        fetchUsersFromFirestore()
    }
    
    @objc func handleSettings() {
        print("Show registartion page")
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
        
    }
    
    fileprivate func fetchUsersFromFirestore() {
        
        let query = Firestore.firestore().collection("users")           //Firestore.firestore().collection("users")
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users:", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
            })
            self.setupFirestoreUserCards()
        }
        
    }
    
    fileprivate func setupFirestoreUserCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardsDeckView.sendSubviewToBack(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
    
    
}


