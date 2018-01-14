//
//  LXCard.swift
//  Concentration
//
//  Created by junyixin on 14/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

struct LXCard {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierfactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierfactory += 1
        return identifierfactory
    }
    
    init() {
        self.identifier = LXCard.getUniqueIdentifier()
    }
}
