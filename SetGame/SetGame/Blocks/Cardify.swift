//
//  Cardify.swift
//  Memorize
//
//  Created by Safak Gezer on 11/27/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import SwiftUI


struct Cardify: AnimatableModifier { //AnimatableModifier = ViewModifier + Animatable protocols
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    //
    var animatableData: Double { // required for conformance to Animatable protocol
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content.cornerRadius(cornerRadius)
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0)
        )
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp:Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

