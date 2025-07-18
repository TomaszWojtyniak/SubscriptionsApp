//
//  AddSubscriptionView.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 11/07/2025.
//

import SwiftUI
import Models
import SharedUtilities

struct AddSubscriptionView: View {
    
    @State private var dataModel: AddSubscriptionDataModel
    let onSave: (Subscription) -> Void
    @Environment(\.dismiss) private var dismiss

    init(subscriptionToEdit: Subscription? = nil, onSave: @escaping (Subscription) -> Void) {
        if let sub = subscriptionToEdit {
            _dataModel = State(initialValue: AddSubscriptionDataModel(subscription: sub))
        } else {
            _dataModel = State(initialValue: AddSubscriptionDataModel())
        }
        self.onSave = onSave
    }
    
    var body: some View {
        Form {
            Section(header: Text("add.subscription.header".localized(.module))) {
                LabeledContent {
                    TextField("", text: $dataModel.name, prompt: Text(""))
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("add.subscription.name.title".localized(.module))
                }
                
                LabeledContent {
                    TextField("", text: $dataModel.monthlyCost)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .onChange(of: dataModel.monthlyCost) { _ , newValue in
                            self.dataModel.filterMonthlyCostTextField(newValue: newValue)
                        }
                } label: {
                    Text("add.subscription.monthly.cost.title".localized(.module))
                }
                
                Picker("add.subscription.type.title".localized(.module), selection: $dataModel.type) {
                    ForEach(SubscriptionType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            
            switch dataModel.type {
            case .cloud:
                AddCloudSubscriptionView(cloudSubscription: $dataModel.cloudSubscription)
            case .entertainment:
                AddEntertainmentSubscriptionView(entertainmentSubscription: $dataModel.entertainmentSubscription)
            case .productivity:
                AddProductivitySubscriptionView(productivitySubscription: $dataModel.productivitySubscription)
            case .fitness:
                AddFitnessSubscriptionView(fitnessSubscription: $dataModel.fitnessSubscription)
            }
        }
        .navigationTitle(dataModel.isEditing ? "edit.subscription.navigation.title".localized(.module) : "add.subscription.navigation.title".localized(.module))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("add.subscription.cancel.button.title".localized(.module)) {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(dataModel.isEditing ? "add.subscription.save.button.title".localized(.module) : "add.subscription.add.button.title".localized(.module)) {
                    guard self.dataModel.isFormValid else { return }
                    
                    if let subscription = self.dataModel.getSubscriptionModel() {
                        onSave(subscription)
                        dismiss()
                    }
                }
                .disabled(!self.dataModel.isFormValid)
            }
        }
    }
}

#Preview {
    AddSubscriptionView(onSave: { _ in })
}
