//
//  OurSetGame.swift
//  SetGame
//
//  Created by Safak Gezer on 12/5/20.
//

import Foundation


class SetGame : ObservableObject {
    @Published var model = createSetGameModel()
    
    var dealtCards: [SetGameModel.Card] {
        get {
            return model.dealtCards
        }
    }
    
    private static func createSetGameModel() -> SetGameModel {
        return SetGameModel()
    }
    
    // Intents
    
    func dealCards() {
        model.dealCards()
    }
    
    func choose(card:SetGameModel.Card) {
        model.choose(card: card)
    }
}
