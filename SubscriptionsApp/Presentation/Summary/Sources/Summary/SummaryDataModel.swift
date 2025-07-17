//
//  SummaryDataModel.swift
//  Summary
//
//  Created by Tomasz Wojtyniak on 17/07/2025.
//

import Foundation
import Models
import SummaryUseCases
import OSLog

private let logger = Logger(subsystem: "SubscriptionsApp", category: "SummaryDataModel")

@MainActor
@Observable
class SummaryDataModel {
    
    let getSummaryUseCase: GetSummaryUseCaseProtocol
    
    var subscriptions: [Subscription] = []
    var isShowingErrorAlert: Bool = false
    
    init(getSummaryUseCase: GetSummaryUseCaseProtocol = GetSummaryUseCase()) {
        self.getSummaryUseCase = getSummaryUseCase
        
        Task {
            await self.getSubscriptionsData()
        }
    }
    
    func getSubscriptionsData() async {
        do {
            self.subscriptions = try await self.getSummaryUseCase.getSubscriptionsData()
        } catch let error {
            logger.error("Error getting subscriptions data: \(error)")
            isShowingErrorAlert = true
        }
    }
    
    var costPerType: [SubscriptionType: Double] {
        var summary: [SubscriptionType: Double] = [:]
        
        for subscription in subscriptions {
            let type = subscription.details.type
            summary[type, default: 0.0] += subscription.monthlyCost
        }
        
        return summary
    }
}
