//
//  Combinations.swift
//  SetGame
//
//  Created by Safak Gezer on 12/12/20.
//

import Foundation


extension RangeReplaceableCollection {
    
    func combinations(of n: Int) -> [SubSequence] {
        guard n > 0 else { return [.init()] }
        guard let first = first else { return [] }
        return combinations(of: n - 1).map { CollectionOfOne(first) + $0 } + dropFirst().combinations(of: n)
    }
    
    func uniqueCombinations(of n: Int) -> [SubSequence] {
        guard n > 0 else { return [.init()] }
        guard let first = first else { return [] }
        return dropFirst().uniqueCombinations(of: n - 1).map { CollectionOfOne(first) + $0 } + dropFirst().uniqueCombinations(of: n)
    }
}
