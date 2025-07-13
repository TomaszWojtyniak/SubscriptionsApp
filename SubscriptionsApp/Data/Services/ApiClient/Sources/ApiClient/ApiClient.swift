//
//  ApiClient.swift
//  ApiClient
//
//  Created by Tomasz Wojtyniak on 12/07/2025.
//

import Foundation

public protocol ApiClientProtocol: Sendable {
    func get(_ url: URL) async throws -> Data
}

enum ApiClientError: Error {
    case error
}

public actor ApiClient: ApiClientProtocol {
    public static let shared = ApiClient()
    
    init() {
        
    }
    
    public func get(_ url: URL) async throws -> Data {
        try await Task.sleep(for: .seconds(5))
        guard let url = Bundle.module.url(forResource: "ApiSubscriptions", withExtension: "json") else {
            throw ApiClientError.error
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            throw ApiClientError.error
        }
    }
}
