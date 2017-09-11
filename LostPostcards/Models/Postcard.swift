//
//  Postcard.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import Foundation

struct Postcard {
    let title: String
    let imageUrl: String
    let sentDate: Date
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.sentDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
