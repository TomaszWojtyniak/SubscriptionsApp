//
//  EntertainmentSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct EntertainmentSubscription: SubscriptionDetails {
    public let type: SubscriptionType = .entertainment
    public let displayName: String
    let renewalDate: Date
    let platform: String
    public let price: Double
    
    public init(displayName: String, renewalDate: Date, platform: String, price: Double) {
        self.displayName = displayName
        self.renewalDate = renewalDate
        self.platform = platform
        self.price = price
    }
}
