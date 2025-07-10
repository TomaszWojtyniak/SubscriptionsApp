//
//  TabBar.swift
//  TabBar
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI
import SubscriptionsList
import Summary

public enum TabBarScreen: Codable, Hashable, Identifiable, CaseIterable {
    case subscriptions
    case summary
    
    public var id: TabBarScreen { self }
}

extension TabBarScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .subscriptions:
            Label("Subscriptions", systemImage: "list.star")
        case .summary:
            Label("Summary", systemImage: "dollarsign.bank.building.fill")
        }
    }
    
    @ViewBuilder @MainActor
    var destination: some View {
        switch self {
        case .subscriptions:
            SubscriptionsNavigationStack()
        case .summary:
            SummaryNavigationStack()
        }
    }
}
