//
//  SubscriptionCellDataModel.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 14/07/2025.
//

import SwiftUI
import OSLog
import Models

private let logger = Logger(subsystem: "SubscriptionsApp", category: "SubscriptionCellDataModel")

@Observable
@MainActor
class SubscriptionCellDataModel {
    
    init() {}
    
    func getSubscriptionDetails(subscription: Subscription) -> String {
        switch subscription.details.type {
        case .entertainment:
            if let entertainment = subscription.getEntertainmentDetails() {
                return "subscriptions.cell.streaming.plan".localized(.module) +  "\(entertainment.streamingPlan)"
            }
            return ""
        case .productivity:
            if let productivity = subscription.getProductivityDetails() {
                return "\(productivity.hasCloudStorage ? "subscriptions.cell.cloud.storage.available".localized(.module) : "subscriptions.cell.cloud.storage.unavailable".localized(.module))"
            }
            return ""
        case .fitness:
            if let fitness = subscription.getFitnessDetails() {
                return "subscriptions.cell.fitness.type".localized(.module) + "\(fitness.fitnessType.rawValue)"
            }
            return ""
        case .cloud:
            if let cloud = subscription.getCloudDetails() {
                return "subscriptions.cell.provider".localized(.module) + "\(cloud.provider)"
            }
            return ""
        }
    }
    
}
