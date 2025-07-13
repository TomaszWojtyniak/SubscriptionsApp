//
//  CloudStorageSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct CloudStorageSubscription: SubscriptionDetails {
    public let type: SubscriptionType = .cloud
    let provider: String
    let storageCapacity: Int
    let syncDevices: Int
    let apiAccess: Bool
    
    public init(provider: String, storageCapacity: Int, syncDevices: Int, apiAccess: Bool) {
        self.provider = provider
        self.storageCapacity = storageCapacity
        self.syncDevices = syncDevices
        self.apiAccess = apiAccess
    }
}

