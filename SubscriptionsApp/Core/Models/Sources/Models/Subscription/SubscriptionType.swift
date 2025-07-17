//
//  SubscriptionType.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import SwiftUI

public enum SubscriptionType: String, Sendable, Codable, CaseIterable {
    case entertainment = "Entertainment"
    case productivity = "Productivity"
    case fitness = "Fitness"
    case cloud = "Cloud"
    
    public var iconName: String {
        switch self {
        case .entertainment: return "tv"
        case .productivity: return "laptopcomputer"
        case .fitness: return "figure.run"
        case .cloud: return "icloud"
        }
    }
    
    public var color: Color {
        switch self {
        case .entertainment: return .red
        case .productivity: return .blue
        case .fitness: return .green
        case .cloud: return .purple
        }
    }
}
