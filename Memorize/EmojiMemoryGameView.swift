//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Safak Gezer on 8/26/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    // ^ Tells the view to redraw yourself whenever this object changes
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
                    .padding()
            }
                .padding()
                .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
//   ^ SwiftUI manages the storage of any property you declare as a @State. When the state value changes, *the view invalidates its appearance and recomputes the body.* Use the state as the single source of truth for a given view.
//    A State instance isn’t the value itself; it’s a means of reading and writing the value. To access a state’s underlying value, use its variable name, which returns the wrappedValue property value.
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)) // do a somersault when matched
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale) // for when cards disappear after being matched
        }
    }
    
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.7
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            let game = EmojiMemoryGame()
            game.choose(card: game.cards.first!)
        return Group {
            EmojiMemoryGameView(viewModel: game)
                .previewDevice("iPhone 11")
        }
    }
}
