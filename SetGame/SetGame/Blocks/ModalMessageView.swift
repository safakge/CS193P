//
//  ModalMessageView.swift
//  SetGame
//
//  Created by Safak Gezer on 12/13/20.
//

import SwiftUI


struct ModalMessageView: View {
    var state: Bool?
    var successMessage: String
    var failureMessage: String
    var modal: Bool = false // TODO
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if let state = state { // don't show if nil
            let message = state ? successMessage : failureMessage
            ZStack {
                VStack {
                    Spacer()
                    Group() {
                        Text(message)
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(state ? Color.green : Color.red)
                    .cornerRadius(25)
                    .frame(maxWidth:300)
                    Spacer().frame(height:50)
                }
            }
            .frame(width: size.width, height: size.height)
            .transition(AnyTransition.move(edge: .bottom))
            .onAppear {
                print("ModalMessageView showing message \(message)")
            }
//            .contentShape(Rectangle()) // makes it modal (commented out until I find a way to make it conditionally applied)
        }
    }
}
