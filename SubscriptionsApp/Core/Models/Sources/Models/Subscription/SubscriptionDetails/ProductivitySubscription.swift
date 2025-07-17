//
//  ProductivitySubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct ProductivitySubscription: SubscriptionDetails {
    public let type: SubscriptionType
    public let userLicenses: Int
    public let hasCloudStorage: Bool
    public let hasAdvancedSecurity: Bool
    
    public init(userLicenses: Int, hasCloudStorage: Bool, hasAdvancedSecurity: Bool) {
        self.type = .productivity
        self.userLicenses = userLicenses
        self.hasCloudStorage = hasCloudStorage
        self.hasAdvancedSecurity = hasAdvancedSecurity
    }
}
