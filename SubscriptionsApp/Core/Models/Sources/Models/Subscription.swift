//
//  Subscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct Subscription: Identifiable {
    public let id = UUID()
    public let name: String
    public let details: SubscriptionDetails
    
    public init(name: String, details: SubscriptionDetails) {
        self.name = name
        self.details = details
    }
}
