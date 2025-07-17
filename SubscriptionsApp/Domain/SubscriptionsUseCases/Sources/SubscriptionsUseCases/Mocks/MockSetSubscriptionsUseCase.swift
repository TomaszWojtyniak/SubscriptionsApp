//
//  MockSetSubscriptionsUseCase.swift
//  SubscriptionsUseCases
//
//  Created by Tomasz Wojtyniak on 17/07/2025.
//

import SwiftUI
import Models

@MainActor
public class MockSetSubscriptionsUseCase: SetSubscriptionsUseCaseProtocol {
    
    public init() {
        
    }
    
    public var subscriptionsToReturn: [Subscription] = []
    public var shouldThrowError = false
    public var errorToThrow: Error = MockError.generic
    
    public func addSubscription(subscription: Subscription) async throws -> [Subscription] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        return subscriptionsToReturn
    }
    
    public func deleteSubscription(id: UUID) async throws -> [Subscription] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        return subscriptionsToReturn
    }
    
    public func updateSubscription(subscription: Subscription) async throws -> [Subscription] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        return subscriptionsToReturn
    }
    
    public func saveLocalData(data: Data) async throws -> [Subscription] {
        if shouldThrowError {
            throw errorToThrow
        }
        
        return subscriptionsToReturn
    }
}
