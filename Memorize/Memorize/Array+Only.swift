//
//  Array+Only.swift
//  Memorize
//
//  Created by Safak Gezer on 10/11/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
