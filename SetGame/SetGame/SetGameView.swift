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
                        .aspectRatio(0.75, contentMode: ContentMode.fit)
                        .foregroundColor(card.chosen ?
                                            (modelView.playerProposedAValidSet != nil ?
                                                (modelView.playerProposedAValidSet! ? .green : .red)
                                                : .orange)
                                            : .gray)
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                modelView.choose(card: card)
                            }
                        }
                }
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            modelView.intentDealCards()
                        }
                    }, label: { Text("Deal Cards") })
                    Button(action: {
                        withAnimation(.easeInOut) {
                            modelView.intentResetGame()
                        }
                    }, label: { Text("New Game") })
                }
                .font(.headline)
            }
        }.onAppear {
            if modelView.dealtCards.count == 0 {
                withAnimation(.easeInOut) {
                    modelView.intentDealCards() // Trigger new game on launch
                }
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
                }
            }
            .foregroundColor(.black)
            .cardify(isFaceUp: true)
            .scaleEffect(CGSize(width: card.chosen ? 1.15 : 1, height: card.chosen ? 1.15 : 1), anchor: .center)
            .padding(metrics.size.width * 0.15)
        }
    }
}


struct OffsetModifier: ViewModifier {
    let movingOffset: CGSize
    
    func body(content: Content) -> some View {
        return content.offset(x: movingOffset.width, y: movingOffset.height)
    }
}

extension AnyTransition {
    
    static func fly(withCurrentPosition viewPosition:CGPoint?) -> AnyTransition {
        let offset = makeRandomOffScreenLocation(metrics: nil)
        return .modifier(active: OffsetModifier(movingOffset: offset),
                         identity: OffsetModifier(movingOffset: .zero))
    }
    
    static func makeRandomOffScreenLocation(metrics:GeometryProxy?) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        
        let perimeter = (screenBounds.width*2 + screenBounds.height*2)
        
        let randomPoint = CGFloat.random(in: 0...perimeter)
        
        if randomPoint < screenBounds.width {
            return CGSize(width: randomPoint,
                          height: 0) // x movable, y 0
        } else if randomPoint < screenBounds.width + screenBounds.height {
            return CGSize(width: screenBounds.width,
                          height: randomPoint - screenBounds.width) // x full, y movable
        } else if randomPoint < screenBounds.width*2 + screenBounds.height {
            return CGSize(width: randomPoint - (screenBounds.width + screenBounds.height) ,
                          height: screenBounds.height) // y full, x movable
        } else {
            return CGSize(width: 0,
                          height: randomPoint - (screenBounds.width*2 + screenBounds.height)) // x 0, y movable
        }
        //        print("metriks \(metrics.frame(in: .global))")
        //        let absolutePosition = metrics.frame(in: .global)
        //        return CGSize(width: absolutePosition.origin.x + 100, height: absolutePosition.origin.y +  100)
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
