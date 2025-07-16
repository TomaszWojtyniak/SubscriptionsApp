//
//  AddFitnessSubscriptionView 2.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 14/07/2025.
//


import SwiftUI
import Models

struct AddFitnessSubscriptionView: View {
    
    @State private var fitnessType: FitnessType = .basicAccess
    @State private var gymName: String = ""
    
    @Binding var fitnessSubscription: FitnessSubscription?
    
    var body: some View {
        Section(header: Text("fitness.subscription.header".localized(.module))) {
            LabeledContent {
                TextField("", text: $gymName, prompt: Text(""))
                    .multilineTextAlignment(.trailing)
                    .onChange(of: gymName) { _ , _ in
                        updateSubscriptionModel()
                    }
            } label: {
                Text("fitness.subscription.gym.name".localized(.module))
            }
            
            Picker("add.cloud.sync.devices.picker.title".localized(.module), selection: $fitnessType) {
                ForEach(FitnessType.allCases, id: \.self) { type in
                    Text("\(type)")
                }
            }
            .pickerStyle(.menu)
            .onChange(of: fitnessType) { _ , _ in
                updateSubscriptionModel()
            }
        }
        .onAppear {
            updateSubscriptionModel()
        }
    }
    
    private func updateSubscriptionModel() {
        guard !gymName.isEmpty else {
            fitnessSubscription = nil
            return
        }
        
        fitnessSubscription = FitnessSubscription(fitnessType: self.fitnessType, gymName: self.gymName)
    }
}

#Preview {
    AddFitnessSubscriptionView(fitnessSubscription: .constant(FitnessSubscription(fitnessType: .basicAccess, gymName: "MyGym")))
}
