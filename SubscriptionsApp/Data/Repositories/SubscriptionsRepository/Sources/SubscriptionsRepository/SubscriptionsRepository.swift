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
    func saveLocalData(data: Data) async throws -> [Subscription]
    func addSubscriptionElement(_ subscription: Subscription) async throws -> [Subscription]
    func deleteSubscriptionElement(withId id: UUID) async throws -> [Subscription]
}

enum SubscriptionRepositoryError: Error {
    case wrongUrl
    case genericError
}

private let logger = Logger(subsystem: "SubscriptionsApp", category: "SubscriptionsRepository")

public actor SubscriptionsRepository: SubscriptionsRepositoryProtocol {
    public static let shared = SubscriptionsRepository()
    
    private let apiClient: ApiClientProtocol
    
    private var subscriptions: [Subscription]?
    
    init(apiClient: ApiClientProtocol = ApiClient.shared) {
        self.apiClient = apiClient
    }
    
    public func getSubscriptionsData() async throws -> [Subscription] {
        let fetchedSubscriptions = try await fetchSubscriptionsData()
        self.subscriptions = self.combineSubscriptions(self.subscriptions, fetchedSubscriptions)
        
        return self.subscriptions ?? []
    }
    
    private func fetchSubscriptionsData() async throws -> [Subscription] {
        guard let url = URL(string: "https://api.example.com/subscriptions") else { throw SubscriptionRepositoryError.wrongUrl }
        let data = try await self.apiClient.get(url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(SubscriptionResponse.self, from: data)
        
        
        return response.subscriptions
    }
    
    public func saveLocalData(data: Data) async throws -> [Subscription] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(SubscriptionResponse.self, from: data)
        self.subscriptions = self.combineSubscriptions(self.subscriptions, response.subscriptions)
        return self.subscriptions ?? []
    }
    
    private func combineSubscriptions(_ currentSubscriptions: [Subscription]?, _ newSubscriptions: [Subscription]) -> [Subscription] {
        
        let combined = (currentSubscriptions ?? []) + newSubscriptions
        var seenIds = Set<String>()
        
        return combined.compactMap { subscription in
            seenIds.insert(subscription.id.uuidString).inserted ? subscription : nil
        }
    }
    
    public func addSubscriptionElement(_ subscription: Subscription) async throws -> [Subscription] {
        //Simulate updating subscriptions list to backend
        guard let url = URL(string: "https://api.example.com/subscriptions") else { throw SubscriptionRepositoryError.wrongUrl }
        _ = try await self.apiClient.post(url, body: Data())
        self.subscriptions = self.combineSubscriptions(subscriptions, [subscription])
        return self.subscriptions ?? []
    }
    
    public func deleteSubscriptionElement(withId id: UUID) async throws -> [Subscription] {
        //Simulate updating subscriptions list to backend
        guard let url = URL(string: "https://api.example.com/subscriptions") else { throw SubscriptionRepositoryError.wrongUrl }
        _ = try await self.apiClient.post(url, body: Data())
        guard var currentSubscriptions = self.subscriptions else {
            return []
        }
        
        currentSubscriptions.removeAll { $0.id == id }
        self.subscriptions = currentSubscriptions
        return currentSubscriptions
    }
}

