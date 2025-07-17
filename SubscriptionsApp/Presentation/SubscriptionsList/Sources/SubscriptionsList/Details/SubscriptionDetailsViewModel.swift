//
//  SubscriptionDetailsViewModel.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 16/07/2025.
//

import UIKit
import Models
import SharedUtilities

protocol SubscriptionDetailsViewModelProtocol {
    func formattedPrice(for subscription: Subscription) -> String
}

class SubscriptionDetailsViewModel: SubscriptionDetailsViewModelProtocol {
    init() {
        
    }
    
    func formattedPrice(for subscription: Subscription) -> String {
        "monthly.cost.title".localized(.module)  + String(format: " €%.2f", subscription.monthlyCost)
    }
}
