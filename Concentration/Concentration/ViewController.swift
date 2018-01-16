//
//  ViewController.swift
//  Concentration
//
//  Created by junyixin on 12/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    lazy var game = LXConcentrationModel(numberOfPaircards: cardButtons.count / 2)
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            
            // 更新状态
            updateViewFromModel()
        } else {
            print("你选择的卡片不存在")
        }
    }
    
    func updateViewFromModel() {
        var successArray = [Bool]()
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            successArray.append(card.isMatched)
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        // 判断游戏是否结束
        if (!successArray.contains(false)) {
            let alert = UIAlertController(title: "Tips", message: "Game Over!!!", preferredStyle: .alert)
            let sureAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(sureAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var emojiChoices = ["👻", "🎃", "😇", "😀", "😂", "🤣", "😝"]
    var emoji = Dictionary<Int, String>()
    
    func emoji(for card: LXCard) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

