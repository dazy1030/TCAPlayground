//
//  ListItemExtension.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import Foundation

extension ListItemReducer.State {
    init(imageID: Int) {
        let imageURL = URL(string: "https://picsum.photos/id/\(imageID)/300/300")
        self.init(id: .init(), title: "Item\(imageID)", imageURL: imageURL)
    }
}
