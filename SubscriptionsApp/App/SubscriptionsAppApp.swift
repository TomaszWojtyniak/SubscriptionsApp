//
//  SubscriptionsAppApp.swift
//  SubscriptionsApp
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI
import TabBar

@main
struct SubscriptionsAppApp: App {
    
    @State private var selection: TabBarScreen? = .subscriptions
    
    var body: some Scene {
        WindowGroup {
            TabBarView(selection: $selection)
        }
    }
}
