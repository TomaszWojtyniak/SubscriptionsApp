//
//  MockGetSubscriptionsUseCase.swift
//  SubscriptionsUseCases
//
//  Created by Tomasz Wojtyniak on 17/07/2025.
//

import SwiftUI
import Models

@MainActor
public class MockGetSubscriptionsUseCase: GetSubscriptionsUseCaseProtocol {
    
    public init() {
        
    }
    
    public var subscriptionsToReturn: [Subscription] = []
    public var shouldThrowError = false
    public var errorToThrow: Error = MockError.generic
    
    public func getSubscriptionsData() async throws -> [Subscription] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        return subscriptionsToReturn
    }
}
