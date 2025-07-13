//
//  CloudStorageSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct CloudStorageSubscription: SubscriptionDetails {
    public let type: SubscriptionType
    public let provider: String
    public let storageCapacity: Int
    public let syncDevices: Int
    public let apiAccess: Bool
    
    public init(provider: String, storageCapacity: Int, syncDevices: Int, apiAccess: Bool) {
        self.type = .cloud
        self.provider = provider
        self.storageCapacity = storageCapacity
        self.syncDevices = syncDevices
        self.apiAccess = apiAccess
    }
}

