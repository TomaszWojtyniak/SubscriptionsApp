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

private let logger = Logger(subsystem: "SubscriptionsApp", category: "SubscriptionsDataModel")

@Observable
@MainActor
class SubscriptionsDataModel {
    let getSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol
    let setSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol
    
    var subscriptions: [Subscription] = []
    var selectedSubscription: Subscription?
    var isShowingAddSubscriptionSheet: Bool = false
    
    init(getSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol = GetSubscriptionsUseCase(),
        setSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol = SetSubscriptionsUseCase()) {
        self.getSubscriptionsUseCase = getSubscriptionsUseCase
        self.setSubscriptionsUseCase = setSubscriptionsUseCase
    }
    
    func getSubscriptionsData() async {
        do {
            let subscriptions = try await self.getSubscriptionsUseCase.getSubscriptionsData()
            self.subscriptions = subscriptions
        } catch let error {
            logger.error("Error getting subscriptions data: \(error)")
            //Handle error with popup
        }
    }
    
    func removeSubscription(at indexSet: IndexSet) {
        subscriptions.remove(atOffsets: indexSet)
    }
    
    func addSubscription(_ subscription: Subscription) {
        subscriptions.append(subscription)
    }
}
