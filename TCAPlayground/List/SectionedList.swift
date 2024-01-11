//
//  SectionedList.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SectionedListReducer {
    struct State: Equatable {
        var sections: IdentifiedArrayOf<ListSectionReducer.State>
    }
    
    enum Action {
        case sections(IdentifiedActionOf<ListSectionReducer>)
    }
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
            .forEach(\.sections, action: \.sections) {
                ListSectionReducer()
            }
    }
}

struct SectionedList: View {
    let store: StoreOf<SectionedListReducer>
    @ObservedObject var viewStore: ViewStoreOf<SectionedListReducer>
    
    init(store: StoreOf<SectionedListReducer>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }
    
    var body: some View {
        List {
            ForEachStore(store.scope(state: \.sections, action: \.sections)) { store in
                ListSection(store: store)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Sectioned List")
    }
}

#Preview {
    SectionedList(
        store: .init(
            initialState: SectionedListReducer.State(sections: .template)
        ) {
            SectionedListReducer()
        }
    )
}
