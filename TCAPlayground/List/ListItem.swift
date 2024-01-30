//
//  ListItem.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import NukeUI
import SwiftUI

@Reducer
struct ListItemReducer {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        var title: String
        var imageURL: URL?
    }
    
    enum Action {}
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}

struct ListItem: View {
    let store: StoreOf<ListItemReducer>
    
    var body: some View {
        HStack(spacing: 0) {
            Text(store.title)
            Spacer()
            LazyImage(url: store.imageURL) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    ListItem(
        store: .init(
            initialState: ListItemReducer.State(imageID: 0)
        ) {
            ListItemReducer()
        }
    )
}
