//
//  Subscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct Subscription: Identifiable, Hashable, Sendable, Codable {
    public let id: UUID
    public let name: String
    public let monthlyCost: Double
    private let _details: AnySubscriptionDetails
    
    public var details: any SubscriptionDetails {
        return _details.wrappedValue
    }
    
    public init(id: UUID = UUID(), name: String, monthlyCost: Double, details: any SubscriptionDetails) {
        self.id = id
        self.name = name
        self.monthlyCost = monthlyCost
        self._details = AnySubscriptionDetails(details)
    }
    
    public init(id: UUID, name: String, monthlyCost: Double, details: AnySubscriptionDetails) {
        self.id = id
        self.name = name
        self.monthlyCost = monthlyCost
        self._details = details
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs.id == rhs.id
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, monthlyCost, details
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        monthlyCost = try container.decode(Double.self, forKey: .monthlyCost)
        _details = try container.decode(AnySubscriptionDetails.self, forKey: .details)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(monthlyCost, forKey: .monthlyCost)
        try container.encode(_details, forKey: .details)
    }
    
    private func getSubscriptionDetails<T: SubscriptionDetails>() -> T? {
        return details as? T
    }
}

public extension Subscription {
    func getEntertainmentDetails() -> EntertainmentSubscription? {
        return getSubscriptionDetails()
    }
    
    func getProductivityDetails() -> ProductivitySubscription? {
        return getSubscriptionDetails()
    }
    
    func getFitnessDetails() -> FitnessSubscription? {
        return getSubscriptionDetails()
    }
    
    func getCloudDetails() -> CloudStorageSubscription? {
        return getSubscriptionDetails()
    }
}
