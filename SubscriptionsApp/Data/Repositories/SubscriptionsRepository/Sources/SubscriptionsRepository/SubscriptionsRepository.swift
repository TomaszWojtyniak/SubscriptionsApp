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
        
        return []
    }
}
