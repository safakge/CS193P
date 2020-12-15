//
//  SetGameView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/3/20.
//

import SwiftUI


struct SetGameView: View {
    @ObservedObject var modelView: ShapedSetGame
    
    static var cardFlyAnimation: Animation = Animation.easeOut(duration:0.5)
    
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
                        .transition(.fly)
                        .rotationEffect(Angle.degrees(card.chosen ? 5 : 0))
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
    let flyingOffset: CGSize
    
    func body(content: Content) -> some View {
        return content.offset(x: flyingOffset.width, y: flyingOffset.height)
    }
}

extension AnyTransition {
    
    static var fly:AnyTransition {
        let flyingOffset = makeRandomOffScreenLocation()
        print("flyingOffset \(flyingOffset)")
        return .modifier(active: OffsetModifier(flyingOffset: flyingOffset),
                         identity: OffsetModifier(flyingOffset: .zero))
    }
    
    static func fly(withCurrentPosition viewPosition:CGPoint?) -> AnyTransition {
        let offset = makeRandomOffScreenLocation()
        return .modifier(active: OffsetModifier(flyingOffset: offset),
                         identity: OffsetModifier(flyingOffset: .zero))
    }
    
    static func makeRandomOffScreenLocation() -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let offsetSize = CGSize(width: screenBounds.width*2, height: screenBounds.height*2)
        
        print("bounds \(screenBounds), ENLARGED: <<<\(offsetSize)>>>")
        
        let perimeter = (offsetSize.width*2 + offsetSize.height*2)
        
        let randomPoint = CGFloat.random(in: 0...perimeter)
        
        let retVal:CGSize
        if randomPoint < screenBounds.width {
            retVal = CGSize(width: randomPoint,
                          height: 0) // x movable, y 0
        } else if randomPoint < screenBounds.width + screenBounds.height {
            retVal = CGSize(width: screenBounds.width,
                          height: randomPoint - screenBounds.width) // x full, y movable
        } else if randomPoint < screenBounds.width*2 + screenBounds.height {
            retVal = CGSize(width: randomPoint - (screenBounds.width + screenBounds.height) ,
                          height: screenBounds.height) // y full, x movable
        } else {
            retVal = CGSize(width: 0,
                          height: randomPoint - (screenBounds.width*2 + screenBounds.height)) // x 0, y movable
        }
        
        return CGSize(width: retVal.width - screenBounds.width, height: retVal.height - screenBounds.height)
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
