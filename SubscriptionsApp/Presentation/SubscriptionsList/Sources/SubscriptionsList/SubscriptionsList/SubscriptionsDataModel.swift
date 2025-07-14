//
//  SubscriptionsDataModel.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 10/07/2025.
//

import SwiftUI
import Models
import SubscriptionsUseCases
import OSLog
import CoreResources

private let logger = Logger(subsystem: "SubscriptionsApp", category: "SubscriptionsDataModel")

@Observable
@MainActor
class SubscriptionsDataModel {
    let getSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol
    let setSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol
    
    var subscriptions: [Subscription] = []
    var selectedSubscription: Subscription?
    var isShowingAddSubscriptionSheet: Bool = false
    var isShowingErrorAlert: Bool = false
    
    init(getSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol = GetSubscriptionsUseCase(),
        setSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol = SetSubscriptionsUseCase()) {
        self.getSubscriptionsUseCase = getSubscriptionsUseCase
        self.setSubscriptionsUseCase = setSubscriptionsUseCase
    }
    
    func getSubscriptionsData() async {
        do {
            self.subscriptions = try await self.getSubscriptionsUseCase.getSubscriptionsData()
        } catch let error {
            logger.error("Error getting subscriptions data: \(error)")
            isShowingErrorAlert = true
        }
    }
    
    func removeSubscription(at indexSet: IndexSet) {
        Task {
            if let index = indexSet.first {
                let subscriptionId = self.subscriptions[index].id
                do {
                    self.subscriptions = try await self.setSubscriptionsUseCase.deleteSubscription(id: subscriptionId)
                } catch let error {
                    logger.error("Error deleting subscription element: \(error)")
                    isShowingErrorAlert = true
                }
            }
        }
    }
    
    func addSubscription(_ subscription: Subscription) {
        Task {
            do {
                self.subscriptions = try await self.setSubscriptionsUseCase.addSubscription(subscription: subscription)
            } catch let error {
                logger.error("Error adding subscription element: \(error)")
                isShowingErrorAlert = true
            }
        }
    }
    
    func addLocaleData() async {
        do {
            guard let jsonData = getJsonData() else {
                logger.error("Error getting data from a file")
                isShowingErrorAlert = true
                return
            }
            self.subscriptions = try await self.setSubscriptionsUseCase.saveLocalData(data: jsonData)
        } catch let error {
            logger.error("Error loading locale data: \(error)")
            isShowingErrorAlert = true
        }
    }
}
