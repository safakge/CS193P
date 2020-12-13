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
    
    /// Returns:
    /// true: If chosen cards are valid set
    /// false: If chosen cards are not a valid set
    /// nil: If not enough cards are yet chosen by player
    var playerProposedAValidSet: Bool? {
        guard model.chosenCardIndices.count == 3 else {
            return nil
        }
        return model.chosenCardsAreAValidSet()
    }
    
    var hudMessageToShow: String? {
        if let playerProposedAValidSet = playerProposedAValidSet {
            return playerProposedAValidSet ? "Set!" : "Not a set. Try again."
        }
        return nil
    }
    
    // Intents
    
    func intentDealCards() {
        if model.chosenCardsAreAValidSet() {
            model.progressGameAfterSetCandidateWasProposed(withNextChosenCard: nil)
        } else {
            model.dealCards()
        }
    }
    
    func intentResetGame() {
        model.resetDeck()
        model.dealCards()
    }
    
    func choose(card:SetGame.Card) {
        model.toggleChosen(forCard: card)
    }
    
    var dbg_ShowHud: Bool = false
}
