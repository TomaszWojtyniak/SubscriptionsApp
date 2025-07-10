//
//  SubscriptionsView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI
import Models

struct SubscriptionsView: View {
    
    @State private var dataModel =  SubscriptionsDataModel()
    @State private var selectedSubscription: Subscription?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.dataModel.subscriptions) { subscription in
                    SubscriptionCellView(subscription: subscription)
                }
                .onDelete { index in
                    dataModel.removeSubscription(at: index)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        
                    }
                }
            }
            .navigationTitle("Subscriptions")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationDestination(item: $selectedSubscription) { subscription in
            
        }
    }
}

#Preview {
    SubscriptionsView()
}
