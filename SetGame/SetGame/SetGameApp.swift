//
//  SetGameApp.swift
//  SetGame
//
//  Created by Safak Gezer on 12/3/20.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        let modelView = ShapedSetGame()
        
        return WindowGroup {
            SetGameView(modelView: modelView)
        }
    }
}
