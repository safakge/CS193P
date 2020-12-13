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
    
    var playerPickedASetCandidate: Bool {
        return model.chosenCardIndices.count == 3
    }
    
    var hudMessageToShow: String? {
        if playerPickedASetCandidate {
            // TODO different outcomes for set / non-set
            return "You picked three cards."
        }
        
        return nil
    }
    
    // Intents
    
    func intentProgressGameAfterPickingCards() {
        model.resetChosenCards() // TODO: replace with method that does more by progressing the game based on 
    }
    
    func intentDealCards() {
        model.dealCards()
    }
    
    func intentShuffleCardsBack() {
        model.resetDeck()
    }
    
    func choose(card:SetGame.Card) {
        model.toggleChosen(forCard: card)
    }
    
    var dbg_ShowHud: Bool = false
}
