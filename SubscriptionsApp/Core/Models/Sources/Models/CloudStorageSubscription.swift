//
//  CloudStorageSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct CloudStorageSubscription: SubscriptionDetails {
    public let type: SubscriptionType = .cloud
    public let displayName: String
    public let price: Double
    let storageCapacity: Int
    let monthlyPrice: Double
    let providerName: String
    
    public init(displayName: String, price: Double, storageCapacity: Int, monthlyPrice: Double, providerName: String) {
        self.displayName = displayName
        self.price = price
        self.storageCapacity = storageCapacity
        self.monthlyPrice = monthlyPrice
        self.providerName = providerName
    }
}
