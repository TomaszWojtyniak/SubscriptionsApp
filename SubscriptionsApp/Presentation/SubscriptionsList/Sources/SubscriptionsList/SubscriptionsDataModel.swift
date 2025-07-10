//
//  SubscriptionsDataModel.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import SwiftUI
import Models

@Observable
@MainActor
class SubscriptionsDataModel {
    let subscriptions: [Subscription] = [
        Subscription(name: "Subscription 1", details: EntertainmentSubscription(displayName: "subscription 1", renewalDate: .now, platform: "Netflix", price: 20.0)),
        Subscription(name: "Subscription 2", details: EntertainmentSubscription(displayName: "subscription 2", renewalDate: .now, platform: "HBO", price: 20.0)),
        Subscription(name: "Subscription 3", details: EntertainmentSubscription(displayName: "subscription 3", renewalDate: .now, platform: "Disney+", price: 20.0)),
    ]
}
