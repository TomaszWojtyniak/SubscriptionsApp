//
//  AddProductivitySubscriptionView 2.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 14/07/2025.
//


import SwiftUI
import Models

struct AddProductivitySubscriptionView: View {
    
    @Binding var productivitySubscription: ProductivitySubscription?
    
    @State private var userLicenses: Int = 0
    @State private var hasCloudStorage: Bool = false
    @State private var hasAdvancedSecurity: Bool = false
    
    var body: some View {
        Section(header: Text("productivity.subscription.header".localized(.module))) {
            Picker("user.licenses.title".localized(.module), selection: $userLicenses) {
                ForEach(Array(0...10), id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.menu)
            .onChange(of: userLicenses) { _ , _ in
                updateSubscriptionModel()
            }
            
            Toggle(isOn: $hasCloudStorage) {
                Text("cloud.storage.title".localized(.module))
            }
            .onChange(of: hasCloudStorage) { _ , _ in
                updateSubscriptionModel()
            }
            
            Toggle(isOn: $hasAdvancedSecurity) {
                Text("advanced.security.title".localized(.module))
            }
            .onChange(of: hasAdvancedSecurity) { _ , _ in
                updateSubscriptionModel()
            }
        }
        .onAppear {
            updateSubscriptionModel()
        }
    }
    
    private func updateSubscriptionModel() {
        productivitySubscription = ProductivitySubscription(userLicenses: userLicenses, hasCloudStorage: hasCloudStorage, hasAdvancedSecurity: hasAdvancedSecurity)
    }
}

#Preview {
    AddProductivitySubscriptionView(productivitySubscription: .constant(ProductivitySubscription(userLicenses: 1, hasCloudStorage: false, hasAdvancedSecurity: false)))
}
