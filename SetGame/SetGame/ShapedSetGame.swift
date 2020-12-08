//
//  ShapedSetGame.swift
//  SetGame
//
//  Created by Safak Gezer on 12/5/20.
//

import Foundation


class ShapedSetGame : ObservableObject {
    @Published var model = createSetGameModel()
    
    var dealtCards: [SetGame.Card] {
        get {
            return model.dealtCards
        }
    }
    
    private static func createSetGameModel() -> SetGame {
        return SetGame()
    }
    
    // Intents
    
    func dealCards() {
        model.dealCards()
    }
    
    func choose(card:SetGame.Card) {
        model.toggleChosen(forCard: card)
    }
}
