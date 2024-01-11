//
//  ListSectionsTemplate.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture

extension IdentifiedArrayOf<ListSectionReducer.State> {
    static var template: Self {
        var sections: IdentifiedArrayOf<ListSectionReducer.State> = []
        var imageID = 0
        for sectionIndex in 0..<10 {
            var items: IdentifiedArrayOf<ListItemReducer.State> = []
            for _ in 0..<10 {
                items.append(.init(imageID: imageID))
                imageID += 1
            }
            sections.append(.init(id: .init(), title: "Section\(sectionIndex)", items: items))
        }
        return sections
    }
}
