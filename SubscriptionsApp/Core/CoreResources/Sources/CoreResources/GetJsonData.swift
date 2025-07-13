//
//  GetJsonData.swift
//  CoreResources
//
//  Created by Tomasz Wojtyniak on 13/07/2025.
//

import Foundation

public func getJsonData() -> Data? {
    guard let url = Bundle.module.url(forResource: "Subscriptions", withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: url)
}
