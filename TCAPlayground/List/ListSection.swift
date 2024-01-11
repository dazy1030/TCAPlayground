//
//  ListSection.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ListSectionReducer {
    struct State: Equatable, Identifiable {
        let id: UUID
        var title: String
        var items: IdentifiedArrayOf<ListItemReducer.State>
    }
    
    enum Action {
        case items(IdentifiedActionOf<ListItemReducer>)
    }
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
            .forEach(\.items, action: \.items) {
                ListItemReducer()
            }
    }
}

struct ListSection: View {
    let store: StoreOf<ListSectionReducer>
    @ObservedObject var viewStore: ViewStoreOf<ListSectionReducer>
    
    init(store: StoreOf<ListSectionReducer>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }
    
    var body: some View {
        Text(viewStore.title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.6))
        ForEachStore(store.scope(state: \.items, action: \.items)) { store in
            ListItem(store: store)
        }
    }
}

#Preview {
    ListSection(
        store: .init(
            initialState: ListSectionReducer.State(
                id: .init(),
                title: "Preview",
                items: {
                    let items = (0..<5).map { imageID in
                        ListItemReducer.State(imageID: imageID)
                    }
                    return .init(uniqueElements: items)
                }()
            )
        ) {
            ListSectionReducer()
        }
    )
}
