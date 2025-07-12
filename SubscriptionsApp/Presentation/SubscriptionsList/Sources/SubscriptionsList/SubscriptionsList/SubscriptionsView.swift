//
//  SubscriptionsView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI
import Models
import SharedUtilities

struct SubscriptionsView: View {
    
    @State private var dataModel =  SubscriptionsDataModel()
    
    var body: some View {
        NavigationStack {
            if self.dataModel.subscriptions.isEmpty {
                ContentUnavailableView("No subscriptions data", systemImage: "exclamationmark.shield.fill")
            } else {
                List {
                    ForEach(self.dataModel.subscriptions) { subscription in
                        SubscriptionCellView(subscription: subscription)
                    }
                    .onDelete { index in
                        dataModel.removeSubscription(at: index)
                    }
                }
                .refreshable {
                    await self.dataModel.getSubscriptionsData()
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
                .navigationTitle("subscriptions.navigation.title".localized(.module))
                .navigationBarTitleDisplayMode(.automatic)
            }
        }
        .sheet(isPresented: $dataModel.isShowingAddSubscriptionSheet, content: {
            AddSubscriptionView()
        })
        .navigationDestination(item: $dataModel.selectedSubscription) { subscription in

        }
        .task {
            await self.dataModel.getSubscriptionsData()
        }
    }
}

#Preview {
    SubscriptionsView()
}
