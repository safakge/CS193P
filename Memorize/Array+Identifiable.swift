//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Safak Gezer on 10/11/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable {
    
    func firstIndex(matching element:Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == element.id {
                return index
            }
        }
        return nil
    }
}
