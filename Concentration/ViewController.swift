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
    // Restricition for Lazy: No didSet allowed
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // Computed Property. Get only, no "get" required
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // Private(set): Other classes can "get", but not "set"
    // NSAttributedString: attributes for a string (dictionary?)
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    // NSAttributedString: attributes for a string (dictionary?)
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // MARK: Handle Card Touch Behavior
    @IBAction private func touchCard(_ sender: UIButton) {
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
    
    private func updateViewFromModel() {
        
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
    
    //private var emojiChoices = ["🎃","👻", "😭", "🐲", "👹", "😱", "☠️", "🕷", "☃️"]
    private var emojiChoices = "🎃👻😭🐲👹😱☠️🕷☃️"
    
    
    // Dictionary. Int key, String (emoji) value
    // var emoji = Dictionary<Int, String>()
    // Shorthand version: [ () to iniitialize empty map]
    private var emoji = [Card:String]()
    
    // populate emoji dictionary/map
    private func emoji(for card: Card) -> String {
        
        // Notice the ",". We can put back to back if statements like this!!!! Wow
        if emoji[card] == nil, emojiChoices.count > 0 {
            
            // grab a random emoji, put it in the emoji map. Remove it from emojiChoices
            // we made an extension to Int, and created arc4random. Below in Extension
            
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
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
        return emoji[card] ?? "?"
    }
    
}


// Extensions: Add methods/properties to class/struct/enum (even if we don't have source)
// Restriction: Can't re-implement methods props already there. Props we add can have no
// storage associated with them (computed only)
// Very powerful. Should be used if addition makes sense for the class/struct/enum being
// extended
// For example, we will add a random num generator in the Int struct:
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
