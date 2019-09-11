//
//  MatchesMessagesController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/9/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import LBTATools

class MatchCell: LBTAListCell<UIColor> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "42490FE4-66B9-488A-9F46-83B5DB38F4AE"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Username here", font: .systemFont(ofSize: 14, weight: .bold), textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1) , textAlignment: .center, numberOfLines: 2)
    
    override var item: UIColor! {
        didSet {
            backgroundColor = item
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



class MatchesMessagesController: LBTAListController<MatchCell, UIColor>, UICollectionViewDelegateFlowLayout {
    
    let customNavBar = MatchesNavBar()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 140)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [.red, .magenta, .blue, .gray, .green, .brown]
        
        collectionView.backgroundColor = .white
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        collectionView.contentInset.top = 155
        
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}


