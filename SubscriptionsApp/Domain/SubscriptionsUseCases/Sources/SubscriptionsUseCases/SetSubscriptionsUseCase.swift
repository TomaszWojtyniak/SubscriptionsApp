//
//  SetSubscriptionsUseCase.swift
//  SubscriptionsUseCases
//
//  Created by Tomasz Wojtyniak on 12/07/2025.
//

import Foundation
import SubscriptionsRepository
import Models

public protocol SetSubscriptionsUseCaseProtocol: Sendable {
    func saveLocalData(data: Data) async throws -> [Subscription]
    func deleteSubscription(id: UUID) async throws -> [Subscription]
    func addSubscription(subscription: Subscription) async throws -> [Subscription]
    func updateSubscription(subscription: Subscription) async throws -> [Subscription]
}

public actor SetSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol {
    let subscriptionsRepository: SubscriptionsRepositoryProtocol
    
    public init(subscriptionsRepository: SubscriptionsRepositoryProtocol = SubscriptionsRepository.shared) {
        self.subscriptionsRepository = subscriptionsRepository
    }
    
    public func saveLocalData(data: Data) async throws -> [Subscription] {
        try await self.subscriptionsRepository.saveLocalData(data: data)
    }
    
    public func addSubscription(subscription: Subscription) async throws -> [Subscription] {
        try await self.subscriptionsRepository.addSubscriptionElement(subscription)
    }
    
    public func deleteSubscription(id: UUID) async throws -> [Subscription] {
        try await self.subscriptionsRepository.deleteSubscriptionElement(withId: id)
    }
    
    public func updateSubscription(subscription: Subscription) async throws -> [Subscription] {
        try await self.subscriptionsRepository.updateSubscriptionElement(subscription)
    }
}
