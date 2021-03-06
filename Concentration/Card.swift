//
//  Card.swift
//  Concentration
//
//  Created by Hassan Khan on 5/1/19.
//  Copyright © 2019 Hassan Khan. All rights reserved.
//

import Foundation


// In Swift, classes and structs are similiar. Two key differences:
//
// Structs: No Inheritance
//
// Structs are Value Types: gets copied whenever assigned,
// copied, put in an array... etc
// Copy-on-write symantics: only has to make an actual copy
// when modified - so not that bad in terms of efficiency
//
// Classes are reference types: object lives in a heap,
// we have pointer to it. When we pass an object around,
// we are passing pointers to the obj, not a copy/actual obj
// Hashable: subscribing to the Hashable protocol

struct Card: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    // Static function, accessible from Card TYPE
    private static func getUniqueIdentifier() -> Int {
        
        // Can access static vars inside static methods directly
        identifierFactory += 1
        return identifierFactory
    }
    
    // Inits tend to have same external, internal variable names
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
