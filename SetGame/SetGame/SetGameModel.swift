//
//  SetGame.swift
//  SetGame
//
//  Created by Safak Gezer on 12/5/20.
//

import Foundation


struct SetGameModel {
    private(set) var cards: [Card]
    
    init() {
        cards = []
        for index in 0..<64 {
            let card = Card(content: index.description, id: index)
            cards.append(card)
        }
    }
    
    
    struct Card: Identifiable {
        let content: String
        let id: Int
    }
}
