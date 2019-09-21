//
//  Match.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import Firebase
import LBTATools

struct Match {
    let name, profileImageUrl, uid: String
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
