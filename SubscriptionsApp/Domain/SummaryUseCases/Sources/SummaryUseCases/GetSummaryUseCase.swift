//
//  GetSummaryUseCase.swift
//  SummaryUseCases
//
//  Created by Tomasz Wojtyniak on 17/07/2025.
//

import Foundation
import SubscriptionsRepository
import Models

public protocol GetSummaryUseCaseProtocol: Sendable {
    func getSubscriptionsData() async throws -> [Subscription]
}

public actor GetSummaryUseCase: GetSummaryUseCaseProtocol {
    let subscriptionsRepository: SubscriptionsRepositoryProtocol
    
    public init(subscriptionsRepository: SubscriptionsRepositoryProtocol = SubscriptionsRepository.shared) {
        self.subscriptionsRepository = subscriptionsRepository
    }
    
    public func getSubscriptionsData() async throws -> [Subscription] {
        try await subscriptionsRepository.getSubscriptionsData()
    }
}
