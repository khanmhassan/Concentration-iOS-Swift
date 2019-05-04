//
//  Concentration.swift
//  Concentration
//
//  Created by Hassan Khan on 5/1/19.
//  Copyright © 2019 Hassan Khan. All rights reserved.
//

import Foundation

class Concentration {
    
    // If all the vars are initialized, we get a free init for classes
    
    //
    // API: Application Programming Interface
    // API: List of all methods and instance variables in a class
    //
    // Public API: methods and instance variables that other classes
    // can call
    //
    
    // Initialize array of cards using (): creates an empty array
    // we can pass different aprameteres in () as well
    var cards = [Card]()
    
    // Optional: as what if there is no card facing up??
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        // _ can be used for names that we can ignore (not use really)
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        
        cards.shuffle()
    }
}
