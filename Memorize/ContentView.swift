//
//  ContentView.swift
//  Memorize
//
//  Created by Safak Gezer on 8/26/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        HStack() {
            ForEach(0..<4) { index in
                CardView(isFaceUp: false)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp:Bool
    var body: some View {
        ZStack() {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding()
            .accentColor(/*@START_MENU_TOKEN@*/.yellow/*@END_MENU_TOKEN@*/)
    }
}
