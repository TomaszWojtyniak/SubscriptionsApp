//
//  SubscriptionDetails.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public protocol SubscriptionDetails: Sendable, Codable, Equatable {
    var type: SubscriptionType { get }
}
