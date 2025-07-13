//
//  EntertainmentSubscription.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import Foundation

public struct EntertainmentSubscription: SubscriptionDetails {
    public let type: SubscriptionType = .entertainment
    let streamingPlan: StreamingPlan
    let maxStreams: Int
    let has4k: Bool
    
    public init(streamingPlan: StreamingPlan, maxStreams: Int, has4k: Bool) {
        self.streamingPlan = streamingPlan
        self.maxStreams = maxStreams
        self.has4k = has4k
    }
}

public enum StreamingPlan: String, Codable, Sendable {
    case basic
    case standard
    case premium
}
