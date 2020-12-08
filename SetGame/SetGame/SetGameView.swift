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
                        withAnimation {
                            modelView.choose(card: card)
                        }
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
        GeometryReader { metrics in
            VStack {
                VStack {
                    SquiggleShape()
                    DiamondShape()
                    OvalShape()
                }
                .foregroundColor(.green)
                .padding(EdgeInsets(top: metrics.size.height * 0.1, leading: metrics.size.width * 0.1, bottom: metrics.size.height * 0.1, trailing: metrics.size.width * 0.1))
                Text("\(card.id)")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .cardify(isFaceUp: true)
            .scaleEffect(CGSize(width: card.chosen ? 1.15 : 1, height: card.chosen ? 1.15 : 1), anchor: .center)
            .padding(metrics.size.width * 0.15)
            .foregroundColor(card.chosen ? .orange : .gray)
        }
        
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
