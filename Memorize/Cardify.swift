//
//  Cardify.swift
//  Memorize
//
//  Created by Safak Gezer on 11/27/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import SwiftUI


struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if self.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
//                if !card.isMatched {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
//                }
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp:Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

