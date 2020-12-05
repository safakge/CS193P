//
//  Grid.swift
//  Memorize
//
//  Created by Safak Gezer on 10/11/20.
//  Copyright © 2020 Safak Gezer. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item:Identifiable, ItemView:View  {
    private var items:[Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout:GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for:item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout:GridLayout) -> some View {
//        let index = self.items.firstIndex(matching: item)!
        
        let index = self.items.firstIndex { (obj: Item) -> Bool in
            return obj.id == item.id
        }!
        
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
