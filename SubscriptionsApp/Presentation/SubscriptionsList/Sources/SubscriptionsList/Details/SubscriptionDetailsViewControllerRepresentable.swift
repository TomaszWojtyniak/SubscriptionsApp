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
    
    func makeUIViewController(context: Context) -> SubscriptionDetailsViewController {
        let viewController = SubscriptionDetailsViewController(subscription: subscription)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SubscriptionDetailsViewController, context: Context) {
        
    }
}
