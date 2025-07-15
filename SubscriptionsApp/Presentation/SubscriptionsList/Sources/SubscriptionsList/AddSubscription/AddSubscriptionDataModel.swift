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
    
    init() {
        
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
        switch self.type {
        case .cloud:
            if let cloudSubscription, let monthlyCost = Double(self.monthlyCost) {
                return Subscription(name: self.name, monthlyCost: monthlyCost, details: cloudSubscription)
            }
        case .entertainment, .productivity, .fitness:
            return nil
        }
        
        return nil
    }
}
