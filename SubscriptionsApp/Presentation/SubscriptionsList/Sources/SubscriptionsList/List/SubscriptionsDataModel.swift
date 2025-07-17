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
    var isLoading: Bool = false
    
    init(getSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol = GetSubscriptionsUseCase(),
        setSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol = SetSubscriptionsUseCase()) {
        self.getSubscriptionsUseCase = getSubscriptionsUseCase
        self.setSubscriptionsUseCase = setSubscriptionsUseCase
    }
    
    func load() async {
        await self.addLocaleData()
        await self.getSubscriptionsData()
    }
    
    func getSubscriptionsData() async {
        do {
            self.subscriptions = try await self.getSubscriptionsUseCase.getSubscriptionsData()
        } catch let error {
            logger.error("Error getting subscriptions data: \(error)")
            isShowingErrorAlert = true
        }
    }
    
    func removeSubscription(at indexSet: IndexSet) async {
        isLoading = true
        defer { isLoading = false }
        
        if let index = indexSet.first, subscriptions.indices.contains(index) {
            let subscriptionId = self.subscriptions[index].id
            do {
                self.subscriptions = try await self.setSubscriptionsUseCase.deleteSubscription(id: subscriptionId)
            } catch {
                logger.error("Error deleting subscription element: \(error.localizedDescription)")
                isShowingErrorAlert = true
            }
        } else {
            logger.warning("Attempted to delete subscription at invalid index: \(String(describing: indexSet.first))")
        }
    }
    
    func addSubscription(_ subscription: Subscription) async {
        isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.subscriptions = try await self.setSubscriptionsUseCase.addSubscription(subscription: subscription)
            self.isLoading = false
        } catch let error {
            logger.error("Error adding subscription element: \(error)")
            isShowingErrorAlert = true
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
    
    func updateSubscription(_ updatedSubscription: Subscription) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.subscriptions = try await setSubscriptionsUseCase.updateSubscription(subscription: updatedSubscription)
        } catch {
            logger.error("Error updating subscription: \(error)")
            isShowingErrorAlert = true
        }
    }
}
