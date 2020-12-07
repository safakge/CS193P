//
//  ContentView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/3/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var modelView: SetGame
    
    var body: some View {
        Grid(modelView.cards) { card in
            CardView(card: card)
        }
        .foregroundColor(.orange)
    }
}


struct CardView: View {
    var card:SetGameModel.Card
    
    var body: some View {
        Text("\(card.id)")
            .font(.headline)
            .cardify(isFaceUp: true)
            .padding(5)
    }
}












struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = SetGame()
        SetGameView(modelView: modelView)
    }
}
