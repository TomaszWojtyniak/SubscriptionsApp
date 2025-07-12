//
//  SubscriptionsNavigationStack.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI

public struct SubscriptionsNavigationStack: View {
    
    public init() {
        
    }
    
    public var body: some View {
        NavigationStack {
            SubscriptionsView()
        }
    }
}

#Preview {
    SubscriptionsNavigationStack()
}
