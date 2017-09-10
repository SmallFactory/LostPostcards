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
    let date: String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
    }
    
}
