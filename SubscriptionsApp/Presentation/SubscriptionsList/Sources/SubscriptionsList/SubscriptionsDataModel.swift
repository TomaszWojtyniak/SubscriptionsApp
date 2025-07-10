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
    var subscriptions: [Subscription] = [
        Subscription(name: "Subscription 1", details: EntertainmentSubscription(displayName: "subscription 1", renewalDate: .now, platform: "Netflix", price: 20.0)),
        Subscription(name: "Subscription 2", details: CloudStorageSubscription(displayName: "Subscription 2", price: 100.0, storageCapacity: 29, monthlyPrice: 20.0, providerName: "iCloud")),
        Subscription(name: "Subscription 3", details: ProductivitySubscriptions(displayName: "Reminder", price: 2.0)),
        Subscription(name: "Subscription 4", details: FitnessSubscription(displayName: "Subscription 4", price: 20.0, fitnessType: "Gym", paymentRate: 20.0, gymName: "MyGym")),
    ]
    
    func removeSubscription(at indexSet: IndexSet) {
        subscriptions.remove(atOffsets: indexSet)
    }
    
    func addSubscription(_ subscription: Subscription) {
        subscriptions.append(subscription)
    }
}
