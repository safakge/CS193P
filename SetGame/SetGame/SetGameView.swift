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
        VStack {
            Grid(modelView.dealtCards) { card in
                CardView(card: card)
                    .onTapGesture {
                        modelView.choose(card: card)
                    }
            }
            Button(action: {
                modelView.dealCards()
            }, label: { Text("Deal Cards") })
        }
    }
}


struct CardView: View {
    var card:SetGameModel.Card
    
    var body: some View {
        Text("\(card.id)")
            .font(.headline)
            .cardify(isFaceUp: true)
            .padding(5)
            .foregroundColor(card.chosen ? .orange : .gray)
    }
}












struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = SetGame()
        modelView.dealCards()
        modelView.choose(card: modelView.dealtCards.first!)
        return SetGameView(modelView: modelView)
    }
}
