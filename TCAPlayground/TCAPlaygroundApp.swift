//
//  TCAPlaygroundApp.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCAPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            Root(
                store: .init(initialState: RootReducer.State()) {
                    RootReducer()
                }
            )
        }
    }
}
