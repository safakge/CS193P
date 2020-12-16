//
//  SetGame.swift
//  SetGame
//
//  Created by Safak Gezer on 12/5/20.
//

import Foundation


struct SetGame {
    private(set) var deck: [Card]
    private(set) var dealtCards: [Card]
    var chosenCardIndices: [Int] {
        return dealtCards.enumerated().filter {
            (member:EnumeratedSequence<[Card]>.Iterator.Element) -> Bool in
            return member.element.isChosen
        }.map({ $0.offset })
    }
    var dealtCardsContainNoPossibleSets: Bool = false
    
    init() {
        deck = []
        dealtCards = []
        for number in 1...3 {
            for shape in Card.CardFeatureShapeType.allCases {
                for shading in Card.CardFeatureShading.allCases {
                    for color in Card.CardFeatureColor.allCases {
                        let card = Card(numberOfSymbols: number, shapeType: shape, shading: shading, color: color)
                        deck.append(card)
                    }
                }
            }
        }
        resetDeck()
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
    
//    For any "set", the number of features that are all the same and the number of features that are all different may break down as 0 the same + 4 different; or 1 the same + 3 different; or 2 the same + 2 different; or 3 the same + 1 different. (It cannot break down as 4 features the same + 0 different as the cards would be identical, and there are no identical cards in the Set deck.)
    
    private static func cardsFormValidSet(_ cards:[Card], verbose:Bool = false) -> Bool {
        let chosenFeatures = [
            cards.map({ $0.numberOfSymbols }),
            cards.map({ $0.shapeType.rawValue }),
            cards.map({ $0.shading.rawValue }),
            cards.map({ $0.color.rawValue })
        ]
        if verbose { print("\(cards) checking for set...") }
        
        for (index, feat) in chosenFeatures.enumerated() {
            if Set(feat).count == feat.count {
                if verbose { print("Feat #\(index)\(feat) -> all distinct.") }
            } else if Set(feat).count == 1 {
                if verbose { print("Feat #\(index)\(feat) -> all same.") }
            } else {
                // not all the same, not everyone distinct. This feat breaks set.
                if verbose { print("Feat #\(index)\(feat) -> broke set.") }
                if verbose { print("\(cards) is not a set.") }
                return false
            }
        }
        
        if verbose { print("\(cards) forms a set!") }
        return true
    }

    func chosenCardsAreAValidSet() -> Bool {
        return chosenCardIndices.count == 3 &&
            SetGame.cardsFormValidSet(dealtCards.enumerated().filter({ return chosenCardIndices.contains($0.offset) }).map({ $0.element }), verbose: false)
    }
    
    mutating func toggleChosen(forCard card:Card) {
        if let chosenIndex = dealtCards.firstIndex(where: { (cardAtHand:Card) -> Bool in cardAtHand.id == card.id }) {
            let choosing = !dealtCards[chosenIndex].isChosen // as in: not unchoosing
            if self.chosenCardIndices.count == 3 {
                // A card was selected with three chosen cards already on the table, game should progress before new card selection
                progressGameAfterSetCandidateWasProposed(withNextChosenCard: choosing ? card : nil)
                return
            }
            dealtCards[chosenIndex].isChosen = !dealtCards[chosenIndex].isChosen
        } else {
            fatalError("toggleChosen called for undealtCard. Fatal.")
        }
        print("chosenCardIndices: \(self.chosenCardIndices)")
    }
    
    mutating func progressGameAfterSetCandidateWasProposed(withNextChosenCard nextCard:Card?) {
        if chosenCardsAreAValidSet() {
            print("progressGameAfterSetCandidateWasProposed with valid set")
            print("NOT IMPLEMENTED YET")
            // TODO
        } else {
            print("progressGameAfterSetCandidateWasProposed w/o valid set")
            resetChosenCards()
            if let nextCard = nextCard {
                toggleChosen(forCard: nextCard)
            }
        }
    }
    
    mutating func resetChosenCards() {
        for i in 0..<dealtCards.count {
            dealtCards[i].isChosen = false
        }
    }
    
    mutating func resetDeck() {
        resetChosenCards()
        if dealtCards.count > 0 {
            deck.append(contentsOf: dealtCards)
            dealtCards.removeAll()
        }
        deck.shuffle()
    }
    
    mutating func dealCards() {
        if dealtCards.count < 12 {
            while dealtCards.count < 12 {
                dealOne()
            }
        } else {
            for _ in 0..<3 {
                dealOne()
            }
        }
        
        let dealtCombinations = dealtCards.uniqueCombinations(of: 3)
        let setsAvailable = dealtCombinations.filter({ SetGame.cardsFormValidSet(Array($0)) }).map({ Array($0) })

        print("dealCards() In deck: \(deck.count), Dealt: \(dealtCards.count), Available Sets: \(setsAvailable.count) (\(setsAvailable))")
        
        if setsAvailable.count == 0 {
            print("THERE ARE NO SETS ON TABLE!!!")
            print("THERE ARE NO SETS ON TABLE!!!")
            print("THERE ARE NO SETS ON TABLE!!!")
        }
    }
    
    private mutating func dealOne(replacingWithCardAtIndex replaceIndex:Int? = nil) {
        let card = deck.removeLast()
        if let replaceIndex = replaceIndex {
            // TODO
        } else {
            dealtCards.append(card)
        }
    }
    
    struct Card: Identifiable, CustomStringConvertible {
        var isChosen:Bool = false
        
        let numberOfSymbols:Int
        let shapeType:CardFeatureShapeType
        let shading:CardFeatureShading
        let color:CardFeatureColor
        
        var id: Int {
            return numberOfSymbols*1000 + shapeType.rawValue*100 + shading.rawValue*10 + color.rawValue
        }
        
        var description: String {
            return "#\(id)"
        }
    
        var prettyDescription: String {
            return "n: \(numberOfSymbols)\ns: \(shapeType.rawValue)\nh: \(shading.rawValue)\nc: \(color.rawValue)"
        }
        
        enum CardFeatureShapeType: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
        enum CardFeatureShading: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
        enum CardFeatureColor: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
    }
}
