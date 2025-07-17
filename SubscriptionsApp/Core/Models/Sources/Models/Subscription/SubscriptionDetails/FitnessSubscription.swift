//
//  FitnessSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct FitnessSubscription: SubscriptionDetails {
    public let type: SubscriptionType
    public let fitnessType: FitnessType
    public let gymName: String
    
    public init(fitnessType: FitnessType, gymName: String) {
        self.type = .fitness
        self.fitnessType = fitnessType
        self.gymName = gymName
    }
}

public enum FitnessType: String, Codable, Sendable, CaseIterable {
    case fullAccess
    case basicAccess
}
