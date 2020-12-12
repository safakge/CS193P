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
            HStack {
                Text(modelView.bottomMessageContent)
                    .foregroundColor(.red)
                Button(action: {
                    modelView.intentDealCards()
                }, label: { Text("Deal Cards") })
                Button(action: {
                    modelView.intentShuffleCardsBack()
                }, label: { Text("Shuffle Back") })
            }
            .font(.headline)
        }
    }
}


struct CardView: View {
    var card:SetGame.Card
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                VStack {
                    Text("\(card.prettyDescription)")
                        .font(.title3)
                }
                .foregroundColor(.black)
                .padding(EdgeInsets(top: metrics.size.height * 0.1, leading: metrics.size.width * 0.1, bottom: metrics.size.height * 0.1, trailing: metrics.size.width * 0.1))
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
        modelView.intentDealCards()
        modelView.choose(card: modelView.dealtCards.first!)
        return SetGameView(modelView: modelView)
    }
}
