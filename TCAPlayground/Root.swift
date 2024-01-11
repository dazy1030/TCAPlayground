//
//  Root.swift
//  TCAPlayground
//
//  Created by 小田島 直樹 on 1/11/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct RootReducer {
    struct State: Equatable {
        @PresentationState var sectionedList: SectionedListReducer.State?
    }
    
    enum Action {
        case sectionedListSelected
        case sectionedList(PresentationAction<SectionedListReducer.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .sectionedListSelected:
                state.sectionedList = .init(sections: .template)
                return .none
            case .sectionedList:
                return .none
            }
        }
        .ifLet(\.$sectionedList, action: \.sectionedList) {
            SectionedListReducer()
        }
    }
}

struct Root: View {
    let store: StoreOf<RootReducer>
    @ObservedObject var viewStore: ViewStoreOf<RootReducer>
    
    init(store: StoreOf<RootReducer>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }
    
    var body: some View {
        NavigationStack {
            List {
                Button("Sectioned List") {
                    viewStore.send(.sectionedListSelected)
                }
            }
            .navigationTitle("TCA example")
            .navigationDestination(store: store.scope(state: \.$sectionedList, action: \.sectionedList)) { store in
                SectionedList(store: store)
            }
        }
    }
}

#Preview {
    Root(
        store: .init(
            initialState: RootReducer.State()
        ) {
            RootReducer()
        }
    )
}
