//
//  AnySubscriptionDetails.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 13/07/2025.
//

import Foundation

public struct AnySubscriptionDetails: Codable, Sendable {
    private let _details: any SubscriptionDetails
    
    public init(_ details: any SubscriptionDetails) {
        self._details = details
    }
    
    public var wrappedValue: any SubscriptionDetails {
        return _details
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(SubscriptionType.self, forKey: .type)
        
        switch type {
        case .entertainment:
            self._details = try EntertainmentSubscription(from: decoder)
        case .productivity:
            self._details = try ProductivitySubscriptions(from: decoder)
        case .fitness:
            self._details = try FitnessSubscription(from: decoder)
        case .cloud:
            self._details = try CloudStorageSubscription(from: decoder)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch _details {
        case let entertainment as EntertainmentSubscription:
            try entertainment.encode(to: encoder)
        case let productivity as ProductivitySubscriptions:
            try productivity.encode(to: encoder)
        case let fitness as FitnessSubscription:
            try fitness.encode(to: encoder)
        case let cloud as CloudStorageSubscription:
            try cloud.encode(to: encoder)
        default:
            throw EncodingError.invalidValue(_details, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unknown subscription details type"))
        }
    }
}
