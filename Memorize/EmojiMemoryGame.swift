//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Safak Gezer on 8/31/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    // Note: ^ ObservableObject protocol adds var objectWillChange: ObservableObjectPublisher. When there is a change in the model that should be reflected in the UI, we call
    // objectWillChange.send()
    @Published private var model: MemoryGame<String> = createMemoryGame()
    // Note: ^ @Published property wrapper automatically calls objectWillChange.send() whenever the property is mutated
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        let numberOfPairs = 4
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            return emojis[pairIndex % emojis.count]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

