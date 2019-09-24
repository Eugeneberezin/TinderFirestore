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


class RecentMessageCell: LBTAListCell<UIColor> {
    
    
    
    let userProfileImageView = UIImageView(image: #imageLiteral(resourceName: "SDET vs DEV"), contentMode: .scaleToFill)
    let userNameLabel = UILabel(text: "USER NAME", font: .systemFont(ofSize: 16), textColor: .black)
    let messageLabel = UILabel(text: "Some long text message here so it does look like a message", font: .systemFont(ofSize: 16), textColor: .gray, numberOfLines: 2)
    
    
    override var item: UIColor! {
        
    
        didSet {
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        userProfileImageView.layer.cornerRadius = 90 / 2
        
        hstack(userProfileImageView.withWidth(90).withHeight(90),
               stack(userNameLabel, messageLabel),
               spacing: 20,
               alignment: .center
               
            ).padLeft(20).padRight(20)
        addSeparatorView(leadingAnchor: userNameLabel.leadingAnchor)
        
    }
}



class MatchesMessagesController: LBTAListHeaderController<RecentMessageCell, UIColor, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupHeader(_ header: MatchesHeader) {
        header.matchesHorizontalViewController.rootMatchesController = self
    }
    
    func didSelectMatchHeader(match: Match) {
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }

    let customNavBar = MatchesNavBar()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    let topCoverView: UIView = {
        let tcv = UIView()
        tcv.backgroundColor = .white
        return tcv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [.red, .blue, .green, .magenta]
        collectionView.scrollIndicatorInsets.top = 150
        collectionView.backgroundColor = .white
        view.addSubview(topCoverView)
        topCoverView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        view.addSubview(customNavBar)
        customNavBar.anchor(top: topCoverView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        collectionView.contentInset.top = 155
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}


