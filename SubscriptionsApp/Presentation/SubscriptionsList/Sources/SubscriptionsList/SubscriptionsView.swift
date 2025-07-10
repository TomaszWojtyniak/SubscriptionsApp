//
//  SubscriptionsView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI

struct SubscriptionsView: View {
    
    @State private var dataModel =  SubscriptionsDataModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.dataModel.subscriptions) { subscription in
                    SubscriptionCellView(subscription: subscription)
                }
                .onDelete { index in
                    
                }
            }
            .toolbar {
                Button("Edit") {}
                Button("Add") {}
            }
        }
    }
}

#Preview {
    SubscriptionsView()
}
