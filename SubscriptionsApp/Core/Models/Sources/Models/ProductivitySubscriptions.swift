//
//  ProductivitySubscriptions.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct ProductivitySubscriptions: SubscriptionDetails {
    public let type: SubscriptionType = .productivity
    public let displayName: String
    public let price: Double
    
    public init(displayName: String, price: Double) {
        self.displayName = displayName
        self.price = price
    }
}
