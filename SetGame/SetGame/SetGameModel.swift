//
//  SetGame.swift
//  SetGame
//
//  Created by Safak Gezer on 12/5/20.
//

import Foundation


struct SetGameModel {
    private(set) var deck: [Card]
    private(set) var dealtCards:[Card]
    
    init() {
        deck = []
        dealtCards = []
        for number in 1...3 {
            for shape in Card.CardShape.allCases {
                for shading in Card.CardShading.allCases {
                    for color in Card.CardColor.allCases {
                        let card = Card(numberOfSymbols: number, shape: shape, shading: shading, color: color)
                        deck.append(card)
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    mutating func dealCards() {
        while dealtCards.count < 12 {
            let card = deck.removeLast();
            dealtCards.append(card)
        }
        
        print("dealCards() deck: \(deck.count), dealt: \(dealtCards.count)")
    }
    
    struct Card: Identifiable {
        let numberOfSymbols:Int
        let shape:CardShape
        let shading:CardShading
        let color:CardColor
        
        var id: Int {
            return numberOfSymbols*1000 + shape.rawValue*100 + shading.rawValue*10 + color.rawValue
        }
        
        enum CardShape: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
        enum CardShading: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
        enum CardColor: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
    }
}
