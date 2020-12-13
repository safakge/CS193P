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
        ZStack {
            VStack {
                Grid(modelView.dealtCards) { card in
                    CardView(card: card)
                        .foregroundColor(card.chosen ?
                                            (modelView.playerProposedAValidSet != nil ?
                                                (modelView.playerProposedAValidSet! ? .green : .red)
                                                : .orange)
                                            : .gray)
                        .onTapGesture {
                            withAnimation {
                                modelView.choose(card: card)
                            }
                        }
                }
                HStack {
                    Button(action: {
                        modelView.intentDealCards()
                    }, label: { Text("Deal Cards") })
                    Button(action: {
                        modelView.intentResetGame()
                    }, label: { Text("New Game") })
                }
                .font(.headline)
            }
        }
    }
}


struct CardView: View {
    var card:SetGame.Card
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(white: 0.9, opacity: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack {
                    VStack {
                        Text("\(card.prettyDescription)")
                            .font(.title3)
                    }
                    .padding(EdgeInsets(top: metrics.size.height * 0.1, leading: metrics.size.width * 0.1, bottom: metrics.size.height * 0.1, trailing: metrics.size.width * 0.1))
                }
            }
            .foregroundColor(.black)
            .cardify(isFaceUp: true)
            .scaleEffect(CGSize(width: card.chosen ? 1.15 : 1, height: card.chosen ? 1.15 : 1), anchor: .center)
            .padding(metrics.size.width * 0.15)
        }
        
    }
}












struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = ShapedSetGame()
        modelView.intentDealCards()
        modelView.choose(card: modelView.dealtCards.first!)
        modelView.dbg_ShowHud = true
        return SetGameView(modelView: modelView)
    }
}
