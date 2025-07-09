//
//  TabBarView.swift
//  TabBar
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI

public struct TabBarView: View {
    @Binding var selection: TabBarScreen?
    let tabs: [TabBarScreen] = TabBarScreen.allCases
    
    public init(selection: Binding<TabBarScreen?>) {
        self._selection = selection
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            ForEach(tabs) { tab in
                Tab(value: tab) {
                    tab.destination
                } label: {
                    tab.label
                }
            }
        }
    }
}

#Preview {
    TabBarView(selection: .constant(.subscriptions))
}
