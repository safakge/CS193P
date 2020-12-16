//
//  SetGameView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/3/20.
//

import SwiftUI


struct SetGameView: View {
    @ObservedObject var modelView: ShapedSetGame
    
    static var cardFlyAnimation: Animation = Animation.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.75)
    
    var body: some View {
        ZStack {
            VStack {
                Grid(modelView.dealtCards) { card in
                    CardView(card: card)
                        .aspectRatio(0.75, contentMode: ContentMode.fit)
                        .foregroundColor(card.isChosen ?
                                            (modelView.playerProposedAValidSet != nil ?
                                                (modelView.playerProposedAValidSet! ? .green : .red)
                                                : .orange)
                                            : .gray)
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                modelView.choose(card: card)
                            }
                        }
                        .transition(.fly)
                        .rotationEffect(Angle.degrees(card.isChosen ? Double(card.id%50 - 25) / 5 : 0))
                }
                HStack {
                    Button(action: {
                        withAnimation(SetGameView.cardFlyAnimation) {
                            modelView.intentDealCards()
                        }
                    }, label: { Text("Deal Cards") })
                    Button(action: {
                        withAnimation(SetGameView.cardFlyAnimation) {
                            modelView.intentResetGame()
                        }
                    }, label: { Text("New Game") })
                }
                .font(.headline)
            }
            ModalMessageView(state: modelView.playerProposedAValidSet,
                             successMessage: "It's a set! 🙆‍♀️",
                             failureMessage: "Nope. Try again! 🤔",
                             descriptionMessage: "Pick another card to continue").animation(Animation.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.75))
        }.onAppear {
            if modelView.dealtCards.count == 0 {
                withAnimation(SetGameView.cardFlyAnimation) {
                    modelView.intentDealCards() // Trigger new game on launch
                }
            }
        }
    }
}


struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(white: 0.9, opacity: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack {
                    VStack {
                        ForEach(0..<card.numberOfSymbols) { _ in
                            CardShape(shapeType: card.shapeType)
                                .applySetShapeFeatures(forCard: card)
                        }
                        .frame(maxHeight: (metrics.size.height * 0.15)) // magic
                    }
                    .padding()
                }
            }
            .cardify(isFaceUp: true)
            .scaleEffect(CGSize(width: card.isChosen ? 1.15 : 1, height: card.isChosen ? 1.15 : 1), anchor: .center)
            .padding(metrics.size.width * 0.15)
        }
    }
}


struct OffsetModifier: ViewModifier {
    let flyingOffset: CGSize
    
    func body(content: Content) -> some View {
        return content.offset(x: flyingOffset.width, y: flyingOffset.height)
    }
}

extension AnyTransition {
    
    static var fly:AnyTransition {
        func randomDistanceFromCenterToCirclePerimeter(withRadius radius:CGFloat) -> CGSize {
            // Random angle in [0, 2*pi]
            let theta = CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max-1) * CGFloat(Float.pi) * 2.0
            // Convert polar to cartesian
            let x = radius * cos(theta)
            let y = radius * sin(theta)
            
            return CGSize(width: CGFloat(x), height: CGFloat(y))
        }
        
        let longerSide = CGFloat.maximum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
        return .modifier(active: OffsetModifier(flyingOffset: randomDistanceFromCenterToCirclePerimeter(withRadius: longerSide)),
                         identity: OffsetModifier(flyingOffset: .zero))
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
