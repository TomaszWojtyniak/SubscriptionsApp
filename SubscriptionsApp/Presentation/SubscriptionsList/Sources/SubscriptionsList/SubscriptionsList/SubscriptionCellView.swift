//
//  SubscriptionCellView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import SwiftUI
import Models

struct SubscriptionCellView: View {
    
    let subscription: Subscription
    
    var body: some View {
        HStack {
            Image(systemName: subscription.details.type.iconName)
                .foregroundColor(subscription.details.type.color)
                .frame(width: 20)
                .padding(.trailing)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.headline)
                
                Text(self.getSubscriptionDetails())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(subscription.monthlyCost, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
        .padding(.vertical, 4)
    }
    
    func getSubscriptionDetails() -> String {
        switch subscription.details.type {
        case .entertainment:
            if let entertainment = subscription.getEntertainmentDetails() {
                return "Streaming plan: \(entertainment.streamingPlan)"
            }
            return ""
        case .productivity:
            if let productivity = subscription.getProductivityDetails() {
                return "\(productivity.hasCloudStorage ? "Cloud storage available" : "Cloud storage unavailable")"
            }
            return ""
        case .fitness:
            if let fitness = subscription.getFitnessDetails() {
                return "Fitness type: \(fitness.fitnessType.rawValue)"
            }
            return ""
        case .cloud:
            if let cloud = subscription.getCloudDetails() {
                return "Provider: \(cloud.provider)"
            }
            return ""
        }
    }
}

#Preview {
    SubscriptionCellView(subscription: Subscription(id: UUID(), name: "Netflix", monthlyCost: 39.99, details: .init(EntertainmentSubscription(streamingPlan: .basic, maxStreams: 10, has4k: true))))
}
