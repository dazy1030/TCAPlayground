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
    @ObservableState
    struct State: Equatable {
        @Presents var sectionedList: SectionedListReducer.State?
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
    @Bindable var store: StoreOf<RootReducer>
    
    var body: some View {
        NavigationStack {
            List {
                Button("Sectioned List") {
                    store.send(.sectionedListSelected)
                }
            }
            .navigationTitle("TCA example")
            .navigationDestination(
                item: $store.scope(
                    state: \.sectionedList,
                    action: \.sectionedList
                )
            ) { childStore in
                SectionedList(store: childStore)
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
