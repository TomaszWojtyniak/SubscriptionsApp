//
//  SubscriptionCellView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import SwiftUI
import Models

struct SubscriptionCellView: View {
    
    let subscription: Subscription
    
    var body: some View {
        Text(subscription.name)
    }
}

#Preview {
    SubscriptionCellView(subscription: Subscription(name: "Subscription 1", details: EntertainmentSubscription(displayName: "Netflix", renewalDate: .now, platform: "Netflix", price: 20.0)))
}
