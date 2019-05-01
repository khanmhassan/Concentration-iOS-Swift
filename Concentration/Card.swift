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

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    
    var identifier: Int
    
}
