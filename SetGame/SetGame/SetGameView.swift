//
//  SetGameView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/3/20.
//

import SwiftUI

struct ModalMessageView: View {
    var message:String?
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if let message = self.message {
            ZStack {
                VStack() {
                    Text(message)
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(25)
                .frame(maxWidth:300)
            }
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle()) // so the empty area is also clickable
        }
    }
}

struct SetGameView: View {
    @ObservedObject var modelView: ShapedSetGame
    
    var body: some View {
        ZStack {
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
                    Button(action: {
                        modelView.intentDealCards()
                    }, label: { Text("Deal Cards") })
                    Button(action: {
                        modelView.intentShuffleCardsBack()
                    }, label: { Text("Shuffle Back") })
                }
                .font(.headline)
            }
            ModalMessageView(message: modelView.hudMessageToShow)
                .onTapGesture {
                    modelView.intentProgressGameAfterPickingSetCandidate()
                }
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
        modelView.dbg_ShowHud = true
        return SetGameView(modelView: modelView)
    }
}
