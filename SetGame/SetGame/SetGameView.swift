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
        Grid(modelView.cards) { card in
            Text(card.content)
                .cardify(isFaceUp: true)
                .padding()
        }
    }
}



struct CardView: View {
    
    var body: some View {
        Text("Card")
    }
}












struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let modelView = SetGame()
        SetGameView(modelView: modelView)
    }
}
