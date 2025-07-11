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
                    Button {
                        self.dataModel.isShowingAddSubscriptionSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle(Text("subscriptions.navigation.title", bundle: .module))
            .navigationBarTitleDisplayMode(.automatic)
        }
        .sheet(isPresented: $dataModel.isShowingAddSubscriptionSheet, content: {
            AddSubscriptionView()
        })
        .navigationDestination(item: $dataModel.selectedSubscription) { subscription in
            
        }
    }
}

#Preview {
    SubscriptionsView()
}
