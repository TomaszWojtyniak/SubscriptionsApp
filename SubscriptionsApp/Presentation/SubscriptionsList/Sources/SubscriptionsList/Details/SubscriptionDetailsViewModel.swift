//
//  SubscriptionDetailsViewModel.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 16/07/2025.
//

import UIKit
import Models

protocol SubscriptionDetailsViewModelProtocol {
    func formattedPrice(for subscription: Subscription) -> String
}

class SubscriptionDetailsViewModel: SubscriptionDetailsViewModelProtocol {
    init() {
        
    }
    
    func formattedPrice(for subscription: Subscription) -> String {
        String(format: "Monthly cost: €%.2f", subscription.monthlyCost)
    }
}
