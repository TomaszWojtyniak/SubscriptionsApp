//
//  Subscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct Subscription: Identifiable, Hashable, Sendable {
    public let id = UUID()
    public let name: String
    public let monthlyCost: Double
    public let details: any SubscriptionDetails
    
    public init(name: String, monthlyCost: Double, details: any SubscriptionDetails) {
        self.name = name
        self.monthlyCost = monthlyCost
        self.details = details
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs.id == rhs.id
    }
}
