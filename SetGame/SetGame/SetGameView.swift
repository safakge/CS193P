//
//  SetGameView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/3/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var modelView: ShapedSetGame
    
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
    var card:SetGame.Card
    
    var body: some View {
        VStack {
            VStack {
                SquiggleShape()
                DiamondShape()
                OvalShape()
            }.foregroundColor(.red)
            Text("\(card.id)")
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding(20)
        .cardify(isFaceUp: true)
        .padding(card.chosen ? 10 : 20)
        .foregroundColor(card.chosen ? .orange : .gray)
    }
}












struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = ShapedSetGame()
        modelView.dealCards()
        modelView.choose(card: modelView.dealtCards.first!)
        return SetGameView(modelView: modelView)
    }
}
