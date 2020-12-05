//
//  OurSetGame.swift
//  SetGame
//
//  Created by Safak Gezer on 12/5/20.
//

import Foundation


class SetGame : ObservableObject {
    var model = createSetGameModel()
    
    private static func createSetGameModel() -> SetGameModel {
        return SetGameModel()
    }
}
