//
//  FitnessSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct FitnessSubscription: SubscriptionDetails {
    public let type: SubscriptionType = .fitness
    public let displayName: String
    public let price: Double
    let fitnessType: String
    let paymentRate: Double
    let gymName: String
    
    public init(displayName: String, price: Double, fitnessType: String, paymentRate: Double, gymName: String) {
        self.displayName = displayName
        self.price = price
        self.fitnessType = fitnessType
        self.paymentRate = paymentRate
        self.gymName = gymName
    }
}
