//
//  SubscriptionResponse.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 13/07/2025.
//

import Foundation

public struct SubscriptionResponse: Codable {
    public let subscriptions: [Subscription]
    
    public init(subscriptions: [Subscription]) {
        self.subscriptions = subscriptions
    }
}
