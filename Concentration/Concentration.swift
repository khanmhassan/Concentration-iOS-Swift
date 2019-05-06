//
//  Concentration.swift
//  Concentration
//
//  Created by Hassan Khan on 5/1/19.
//  Copyright © 2019 Hassan Khan. All rights reserved.
//

import Foundation

struct Concentration {
    
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
    // private(set): Can get, but not set
    private(set) var cards = [Card]()
    
    // Optional: as what if there is no card facing up??
    // Computed property: Get, Set (set is not mandatory)
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            // using filter to get indexes of faceUp cards
            // if only one face up card, return its index, otherwise return nil
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
            //            // if only one face up card, return its index, otherwise return nul
            //            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
            //            var foundIndex: Int?
            //
            //            for index in cards.indices {
            //                if cards[index].isFaceUp {
            //                    if foundIndex == nil {
            //                        foundIndex = index
            //                    } else {
            //                        return nil
            //                    }
            //                }
            //            }
            //            return foundIndex
        }
        set {
            // set all cards face down except oneAndOnlyFaceUpCard's index
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // Mutating: indicate that a function will "mutate" self. Required for structs. Not in Classes
    mutating func chooseCard(at index: Int) {
        
        // assert is useful for debugging. Protects API. Does not ship when app goes to the App Store
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        // assert is useful for debugging. Protects API. Does not ship when app goes to the App Store
        assert(numberOfPairsOfCards > 0,
               "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        // _ can be used for names that we can ignore (not use really)
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}

// See if there is only one element in ANY collection
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
