//
//  Message.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 9/20/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import Firebase
import LBTATools

struct Message {
    let text, fromId, toId: String
    let timestamp: Timestamp
    
    let isFromCurrentLoggedUser: Bool
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentLoggedUser = Auth.auth().currentUser?.uid == self.fromId
    }
}
