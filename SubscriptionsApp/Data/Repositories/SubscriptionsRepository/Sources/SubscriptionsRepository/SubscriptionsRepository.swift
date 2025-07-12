//
//  SubscriptionsRepository.swift
//  SubscriptionsRepository
//
//  Created by Tomasz Wojtyniak on 12/07/2025.
//

import Foundation
import ApiClient
import Models
import OSLog

public protocol SubscriptionsRepositoryProtocol: Sendable {
    func getSubscriptionsData() async throws -> [Subscription]
}

enum SubscriptionRepositoryError: Error {
    case wrongUrl
    case genericError
}

private let logger = Logger(subsystem: "SubscriptionsApp", category: "SubscriptionsRepository")

public actor SubscriptionsRepository: SubscriptionsRepositoryProtocol {
    public static let shared = SubscriptionsRepository()
    
    let apiClient: ApiClientProtocol
    
    private var subscriptions: [Subscription]?
    
    init(apiClient: ApiClientProtocol = ApiClient.shared) {
        self.apiClient = apiClient
    }
    
    public func getSubscriptionsData() async throws -> [Subscription] {
       if let subscriptions {
           return subscriptions
       }
       
       let fetchedSubscriptions = try await fetchSubscriptionsData()
       self.subscriptions = fetchedSubscriptions
       return fetchedSubscriptions
    }
    
    private func fetchSubscriptionsData() async throws -> [Subscription] {
        guard let url = URL(string: "url") else { throw SubscriptionRepositoryError.wrongUrl }
        let _ = try await self.apiClient.post(url)
        
        return [
            Subscription(name: "Subscription 1", details: EntertainmentSubscription(displayName: "subscription 1", renewalDate: .now, platform: "Netflix", price: 20.0)),
            Subscription(name: "Subscription 2", details: CloudStorageSubscription(displayName: "Subscription 2", price: 100.0, storageCapacity: 29, monthlyPrice: 20.0, providerName: "iCloud")),
            Subscription(name: "Subscription 3", details: ProductivitySubscriptions(displayName: "Reminder", price: 2.0)),
            Subscription(name: "Subscription 4", details: FitnessSubscription(displayName: "Subscription 4", price: 20.0, fitnessType: "Gym", paymentRate: 20.0, gymName: "MyGym")),
        ]
    }
}
