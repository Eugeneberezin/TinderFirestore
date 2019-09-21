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

class MatchesHorizontalController: LBTAListController<MatchCell, Match>, UICollectionViewDelegateFlowLayout {
    
    var rootMatchesController: MatchesMessagesController?
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 110, height: view.frame.height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = items[indexPath.item]
        
        rootMatchesController?.didSelectMatchHeader(match: match)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let leyout = collectionViewLayout as? UICollectionViewFlowLayout {
            leyout.scrollDirection = .horizontal
        }
        
        fetchMatches()
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
    
}

class MatchesHeader: UICollectionReusableView {
    
    let newMatchesLabel = UILabel(text: "Now you can message them", font: .boldSystemFont(ofSize: 18), textColor: #colorLiteral(red: 0.1763901114, green: 0.4974401593, blue: 0.7564814687, alpha: 1))
    
    let matchesHorizontalViewController = MatchesHorizontalController()
    
    let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 18), textColor: #colorLiteral(red: 0.1763901114, green: 0.4974401593, blue: 0.7564814687, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        matchesHorizontalViewController.view.backgroundColor = .yellow
        stack(newMatchesLabel,
              matchesHorizontalViewController.view,
              messagesLabel,
              spacing: 20).withMargins(.init(top: 20, left: 20, bottom: 20, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MatchesMessagesController: LBTAListHeaderController<MatchCell, Match, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    override func setupHeader(_ header: MatchesHeader) {
        header.matchesHorizontalViewController.rootMatchesController = self
    }
    
    func didSelectMatchHeader(match: Match) {
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }

    let customNavBar = MatchesNavBar()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = items[indexPath.item]
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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


