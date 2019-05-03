//
//  ViewController.swift
//  Concentration
//
//  Created by Hassan Khan on 4/28/19.
//  Copyright © 2019 Hassan Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // No need to declare type: Type Inference
    
    // LAZY: Not initialized, until something tries to use it!
    // Restricition: No didSet allowed
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        // Exclamation point at end: assume this optional is set, grab value
        // Can also use "if": if this optional is in set state, execute
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        
        // .indices: countable range of all indexes in array
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                
                // ? : is if else short syntax
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.6003289819, green: 0.6003289819, blue: 0.6003289819, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🎃","👻", "😭", "🐲", "👹", "😱", "☠️", "🕷", "☃️",]
    
    // Dictionary. Int key, String (emoji) value
    // var emoji = Dictionary<Int, String>()
    // Shorthand version: [ () to iniitialize empty map]
    var emoji = [Int:String]()
    
    // populate emoji dictionary/map
    func emoji(for card: Card) -> String {
        
        // Notice the ",". We can put back to back if statements like this!!!! Wow
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            
            // grab a random emoji, put it in the emoji map. Remove it from emojiChoices
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        // this returns an optional. When looking
        // something up in a dictionary, it might
        // not be there.
        // if emoji[card.identifier] != nil {
        //     // We need the exclamation point to "unwrap" the optional
        //     return emoji[card.identifier]!
        // } else {
        //     return "?"
        // }
        // Shorthand for handling nil optionals.
        // if not nil, return emoji, otherwise "?"
        // If nil: ??
        return emoji[card.identifier] ?? "?"
    }
    
}

