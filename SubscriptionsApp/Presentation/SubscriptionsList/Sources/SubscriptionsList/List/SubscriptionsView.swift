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
    
    @State private var dataModel = SubscriptionsDataModel()
    
    var body: some View {
        NavigationStack {
            if self.dataModel.subscriptions.isEmpty {
                ContentUnavailableView("subscription.view.no.data.title".localized(.module), systemImage: "exclamationmark.shield.fill")
            } else {
                ZStack {
                    List {
                        ForEach(self.dataModel.subscriptions) { subscription in
                            SubscriptionCellView(subscription: subscription)
                                .onTapGesture {
                                    self.dataModel.selectedSubscription = subscription
                                }
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
                    .sheet(isPresented: $dataModel.isShowingAddSubscriptionSheet, content: {
                        NavigationStack {
                            AddSubscriptionView { newSubscription in
                                self.dataModel.addSubscription(newSubscription)
                            }
                        }
                    })
                    
                    if dataModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(.circular)
                                .scaleEffect(1.5)
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationDestination(item: $dataModel.selectedSubscription) { subscription in
            SubscriptionDetailsViewControllerRepresentable(subscription: subscription) { updatedSubscription in
                self.dataModel.updateSubscription(updatedSubscription)
            }
        }
        .alert("error.title".localized(.module), isPresented: $dataModel.isShowingErrorAlert, actions: {
            Button("OK", role: .cancel) { }
        })
    }
}

#Preview {
    SubscriptionsView()
}
