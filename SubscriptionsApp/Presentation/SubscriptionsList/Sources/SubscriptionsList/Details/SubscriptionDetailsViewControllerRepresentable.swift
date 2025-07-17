//
//  SubscriptionDetailsViewControllerRepresentable.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 16/07/2025.
//

import SwiftUI
import Models

struct SubscriptionDetailsViewControllerRepresentable: UIViewControllerRepresentable {
    let subscription: Subscription
    let onUpdate: (Subscription) -> Void
    
    func makeUIViewController(context: Context) -> SubscriptionDetailsViewController {
        let viewController = SubscriptionDetailsViewController(subscription: subscription)
        viewController.onUpdate = onUpdate
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SubscriptionDetailsViewController, context: Context) {
        
    }
}
