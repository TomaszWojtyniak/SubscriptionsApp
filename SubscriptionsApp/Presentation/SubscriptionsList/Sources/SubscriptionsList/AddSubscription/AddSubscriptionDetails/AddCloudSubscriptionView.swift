//
//  AddCloudSubscriptionView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 14/07/2025.
//

import SwiftUI
import Models
import SharedUtilities

struct AddCloudSubscriptionView: View {
    
    @State private var provider: String = ""
    @State private var storageCapacity: String = ""
    @State private var syncDevices: Int = 0
    @State private var apiAccess: Bool = false
    
    @Binding var cloudSubscription: CloudStorageSubscription?
    
    var body: some View {
        Section(header: Text("add.cloud.subscription.header".localized(.module))) {
            
            LabeledContent {
                TextField("", text: $provider, prompt: Text(""))
                    .multilineTextAlignment(.trailing)
                    .onChange(of: provider) { _ , _ in
                        updateSubscriptionModel()
                    }
            } label: {
                Text("add.cloud.subscription.provider.title".localized(.module))
            }
            
            LabeledContent {
                TextField("", text: $storageCapacity, prompt: Text(""))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .onChange(of: storageCapacity) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered != newValue {
                            storageCapacity = filtered
                        }
                        updateSubscriptionModel()
                    }
            } label: {
                HStack {
                    Text("add.cloud.subscription.storage.label".localized(.module))
                }
            }
            
            Picker("add.cloud.sync.devices.picker.title".localized(.module), selection: $syncDevices) {
                ForEach(Array(0...10), id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.menu)
            .onChange(of: syncDevices) { _ , _ in
                updateSubscriptionModel()
            }
            
            Toggle(isOn: $apiAccess) {
                Text("add.cloud.subscription.api.access.label".localized(.module))
            }
            .onChange(of: apiAccess) { _ , _ in
                updateSubscriptionModel()
            }
        }
    }
    
    private func updateSubscriptionModel() {
        guard !provider.isEmpty,
              !storageCapacity.isEmpty,
              let capacity = Int(storageCapacity) else {
            cloudSubscription = nil
            return
        }
        
        cloudSubscription = CloudStorageSubscription(
            provider: provider,
            storageCapacity: capacity,
            syncDevices: syncDevices,
            apiAccess: apiAccess
        )
    }
}

#Preview {
    AddCloudSubscriptionView(cloudSubscription: .constant(CloudStorageSubscription(provider: "iCloud", storageCapacity: 20, syncDevices: 5, apiAccess: true)))
}
