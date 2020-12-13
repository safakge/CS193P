//
//  ModalMessageView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/13/20.
//

import SwiftUI


struct ModalMessageView: View {
    var message: String?
    var successful: Bool
    
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
                .background(successful ? Color.green : Color.red)
                .cornerRadius(25)
                .frame(maxWidth:300)
            }
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle()) // so the empty area is also clickable
        }
    }
}
