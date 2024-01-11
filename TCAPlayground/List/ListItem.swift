//
//  ListItem.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ListItemReducer {
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
    @ObservedObject var viewStore: ViewStoreOf<ListItemReducer>
    
    init(store: StoreOf<ListItemReducer>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(viewStore.title)
            Spacer()
            AsyncImage(url: viewStore.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                Color.gray
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
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
