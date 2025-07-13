//
//  ProductivitySubscriptions.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct ProductivitySubscriptions: SubscriptionDetails {
    public let type: SubscriptionType = .productivity
    let userLicenses: Int
    let hasCloudStorage: Bool
    let hasAdvancedSecurity: Bool
    
    public init(userLicenses: Int, hasCloudStorage: Bool, hasAdvancedSecurity: Bool) {
        self.userLicenses = userLicenses
        self.hasCloudStorage = hasCloudStorage
        self.hasAdvancedSecurity = hasAdvancedSecurity
    }
}
