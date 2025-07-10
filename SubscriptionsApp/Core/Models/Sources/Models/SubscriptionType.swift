//
//  SubscriptionType.swift
//  Models
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import SwiftUI

public enum SubscriptionType: CaseIterable {
    case entertainment
    case productivity
    case fitness
    case cloud
    
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
