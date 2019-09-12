//
//  MatchesMessagesController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/9/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools
import Firebase

struct Match {
    let name, profileImageUrl: String
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}

class MatchCell: LBTAListCell<Match> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Username here", font: .systemFont(ofSize: 14, weight: .bold), textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1) , textAlignment: .center, numberOfLines: 2)
    
    override var item: Match! {
        didSet {
            usernameLabel.text = item.name
            profileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        profileImageView.clipsToBounds = true
        profileImageView.constrainWidth(80)
        profileImageView.constrainHeight(80)
        profileImageView.layer.cornerRadius = 80 / 2
        stack(stack(profileImageView, alignment: .center),
              usernameLabel)
        
    }
    
}



class MatchesMessagesController: LBTAListController<MatchCell, Match>, UICollectionViewDelegateFlowLayout {
    
    let customNavBar = MatchesNavBar()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 140)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        items = [
        //            .init(name: "1", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/swipematchfirestore.appspot.com/o/images%2FD5F6A91A-241C-424A-AA96-9AC9E036EC9D?alt=media&token=d367e5c3-59b2-473f-88a5-2dd8057a012d"),
        //            .init(name: "test", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/swipematchfirestore.appspot.com/o/images%2FD5F6A91A-241C-424A-AA96-9AC9E036EC9D?alt=media&token=d367e5c3-59b2-473f-88a5-2dd8057a012d"),
        //            .init(name: "2", profileImageUrl: "profile url"),
        //        ]
        
        fetchMatches()
        
        collectionView.backgroundColor = .white
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        collectionView.contentInset.top = 155
        
    }
    
    fileprivate func fetchMatches() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Failed to fetch mathes", err)
                return
            }
            
            print("MATCHES DOCUMENT")
            var matches = [Match]()
            querySnapshot?.documents.forEach({ (documentSnapshot) in
                let dictionary = documentSnapshot.data()
                matches.append(.init(dictionary: documentSnapshot.data()))
                print("Matches doc>>>>>  ",dictionary)
            })
            
            self.items = matches
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}


