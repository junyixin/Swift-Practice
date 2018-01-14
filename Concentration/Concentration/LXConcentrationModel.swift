//
//  LXConcentrationModel.swift
//  Concentration
//
//  Created by junyixin on 14/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

class LXConcentrationModel {
    var cards = Array<LXCard>()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // 检查是否匹配
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // 没有翻开的卡片或两张卡片不匹配
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPaircards: Int) {
        for _ in 1...numberOfPaircards {
            let card = LXCard()
            cards += [card, card]
        }
        
        // 洗牌
    }
}
