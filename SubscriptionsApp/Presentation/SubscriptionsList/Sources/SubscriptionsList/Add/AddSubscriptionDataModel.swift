//
//  AddSubscriptionDataModel.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 14/07/2025.
//

import SwiftUI
import Models
import OSLog

private let logger = Logger(subsystem: "SubscriptionsApp", category: "AddSubscriptionDataModel")

@Observable
@MainActor
class AddSubscriptionDataModel {
    
    var name: String = ""
    var monthlyCost: String = ""
    var type: SubscriptionType = .cloud
    var cloudSubscription: CloudStorageSubscription?
    var fitnessSubscription: FitnessSubscription?
    var entertainmentSubscription: EntertainmentSubscription?
    var productivitySubscription: ProductivitySubscription?
    
    private(set) var isEditing: Bool = false
    private var originalId: UUID?
    
    //Init for adding subscription
    init() {
        
    }
    
    //Init for editing subscription
    init(subscription: Subscription) {
        self.name = subscription.name
        self.monthlyCost = String(subscription.monthlyCost)
        self.type = subscription.details.type
        self.isEditing = true
        self.originalId = subscription.id

        self.cloudSubscription = subscription.getCloudDetails()
        self.entertainmentSubscription = subscription.getEntertainmentDetails()
        self.fitnessSubscription = subscription.getFitnessDetails()
        self.productivitySubscription = subscription.getProductivityDetails()
    }
    
    func filterMonthlyCostTextField(newValue: String) {
        let filtered = newValue.filter { $0.isNumber || $0 == "." }
        if filtered != newValue {
            self.monthlyCost = filtered
        }
    }
    
    private var isNameValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var isMonthlyCostValid: Bool {
        !monthlyCost.isEmpty && Double(monthlyCost) != nil && (Double(monthlyCost) ?? 0) > 0
    }
    
    private var isTypeSpecificDataValid: Bool {
        switch type {
        case .cloud:
            return cloudSubscription != nil
        case .entertainment, .productivity, .fitness:
            return true
        }
    }
    
    var isFormValid: Bool {
        isNameValid && isMonthlyCostValid && isTypeSpecificDataValid
    }
    
    func getSubscriptionModel() -> Subscription? {
        guard let monthlyCost = Double(self.monthlyCost) else { return nil }

        switch self.type {
        case .cloud:
            if let cloudSubscription {
                return Subscription(id: originalId ?? UUID(), name: name, monthlyCost: monthlyCost, details: cloudSubscription)
            }
        case .entertainment:
            if let entertainmentSubscription {
                return Subscription(id: originalId ?? UUID(), name: name, monthlyCost: monthlyCost, details: entertainmentSubscription)
            }
        case .fitness:
            if let fitnessSubscription {
                return Subscription(id: originalId ?? UUID(), name: name, monthlyCost: monthlyCost, details: fitnessSubscription)
            }
        case .productivity:
            if let productivitySubscription {
                return Subscription(id: originalId ?? UUID(), name: name, monthlyCost: monthlyCost, details: productivitySubscription)
            }
        }

        return nil
    }
}
