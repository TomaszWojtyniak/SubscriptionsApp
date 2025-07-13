//
//  GetSubscriptionsUseCase.swift
//  SubscriptionsUseCases
//
//  Created by Tomasz Wojtyniak on 12/07/2025.
//

import Foundation
import SubscriptionsRepository
import Models

public protocol GetSubscriptionsUseCaseProtocol: Sendable {
    func getSubscriptionsData() async throws -> [Subscription]
}

public actor GetSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol {
    let subscriptionsRepository: SubscriptionsRepositoryProtocol
    
    public init(subscriptionsRepository: SubscriptionsRepositoryProtocol = SubscriptionsRepository.shared) {
        self.subscriptionsRepository = subscriptionsRepository
    }
    
    public func getSubscriptionsData() async throws -> [Subscription] {
        try await self.subscriptionsRepository.getSubscriptionsData()
    }
}
