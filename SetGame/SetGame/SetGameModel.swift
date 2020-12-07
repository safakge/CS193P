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
    var chosenCards:[Card] {
        return dealtCards.filter { (card:Card) -> Bool in
            return card.chosen
        }
    }
    
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
    
    //    A set consists of three cards satisfying all of these conditions:
    //
    //    They all have the same number or have three different numbers.
    //    They all have the same shape or have three different shapes.
    //    They all have the same shading or have three different shadings.
    //    They all have the same color or have three different colors.
    //    The rules of Set are summarized by: If you can sort a group of three cards into "two of ____ and one of ____", then it is not a set.
    //
    //    For example, these three cards form a set:
    //
    //    One red striped diamond
    //    Two red solid diamonds
    //    Three red open diamonds
    //    Given any two cards from the deck, there is one and only one other cards that form a set with them.
    func setFormedWithChosenCards() -> Bool {
        if chosenCards.count == 3 {
            var commonFeaturesAmongCards = 0
            
            // TODO
            
            return commonFeaturesAmongCards == 1
        }
        
        return false
    }
    
    mutating func toggleChosen(forCard card:Card) {
        if let chosenIndex = dealtCards.firstIndex(where: { (cardAtHand:Card) -> Bool in cardAtHand.id == card.id }) {
            let choosing = !dealtCards[chosenIndex].chosen // as in: not unchoosing
            if choosing && self.chosenCards.count == 3 {
                // already chosen three cards, and can't choose more
                return
            }
            dealtCards[chosenIndex].chosen = !dealtCards[chosenIndex].chosen
        } else {
            fatalError("toggleChosen called for undealtCard. Fatal.")
        }
        print("Cards currently chosen are: \(self.chosenCards)")
    }
    
    mutating func dealCards() {
        while dealtCards.count < 12 {
            let card = deck.removeLast();
            dealtCards.append(card)
        }
        
        print("dealCards() deck: \(deck.count), dealt: \(dealtCards.count)")
    }
    
    struct Card: Identifiable, CustomStringConvertible {
        var chosen:Bool = false
        
        let numberOfSymbols:Int
        let shape:CardShape
        let shading:CardShading
        let color:CardColor
        
        var id: Int {
            return numberOfSymbols*1000 + shape.rawValue*100 + shading.rawValue*10 + color.rawValue
        }
        
        var description: String {
            return "\(id)"
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
