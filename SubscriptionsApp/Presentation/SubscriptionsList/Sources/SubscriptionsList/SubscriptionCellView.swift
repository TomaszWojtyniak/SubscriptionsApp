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
                
                Text(subscription.details.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(subscription.details.price, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SubscriptionCellView(subscription: Subscription(name: "Subscription 1", details: EntertainmentSubscription(displayName: "Netflix", renewalDate: .now, platform: "Netflix", price: 20.0)))
}
