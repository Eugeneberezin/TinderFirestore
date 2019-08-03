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
    
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
//            Advertiser(title: "New Video Everyday", brandName: "Eugene Berezin", posterPhotoName: "SDET vs DEV"),
//            User(name: "Eugene", age: 33, profession: "iOS Dev", imageNames: ["42490FE4-66B9-488A-9F46-83B5DB38F4AE", "Screen Shot 2019-07-01 at 6.38.49 PM", "Screen Shot 2019-07-17 at 7.19.22 PM"]),
//            User(name: "Jill", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"]),
//            ] as [ProducesCardViewModel]
//
//        let viewModels = producers.map({return $0.toCardViewModel()})
//        return viewModels
//    }()
//
    
    var cardViewModels = [CardViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        setupLayout()
        setupDummyCards()
        fetchUsersFromFirestore()
    }
    
    @objc func handleSettings() {
        print("Show registartion page")
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
        
    }
    
    fileprivate func fetchUsersFromFirestore() {
        
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users:", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
            })
            self.setupDummyCards()
        }
        
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
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


