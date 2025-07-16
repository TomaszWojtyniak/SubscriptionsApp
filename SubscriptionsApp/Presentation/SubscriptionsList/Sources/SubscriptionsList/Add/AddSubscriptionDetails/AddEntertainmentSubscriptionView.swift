//
//  AddEntertainmentSubscriptionView 2.swift
//  SubscriptionsList
//
//  Created by Tomasz Wojtyniak on 14/07/2025.
//


import SwiftUI
import Models

struct AddEntertainmentSubscriptionView: View {
    
    @Binding var entertainmentSubscription: EntertainmentSubscription?
    
    @State private var streamingPlan: StreamingPlan = .basic
    @State private var maxStreams: Int = 0
    @State private var has4k: Bool = false
    
    var body: some View {
        Section(header: Text("entertainment.subscription".localized(.module))) {
            Picker("streaming.plan".localized(.module), selection: $streamingPlan) {
                ForEach(StreamingPlan.allCases, id: \.self) { plan in
                    Text("\(plan)")
                }
            }
            .pickerStyle(.menu)
            .onChange(of: streamingPlan) { _ , _ in
                updateSubscriptionModel()
            }
            
            Picker("max.streams".localized(.module), selection: $maxStreams) {
                ForEach(Array(0...10), id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.menu)
            .onChange(of: maxStreams) { _ , _ in
                updateSubscriptionModel()
            }
            
            Toggle(isOn: $has4k) {
                Text("4K".localized(.module))
            }
            .onChange(of: has4k) { _ , _ in
                updateSubscriptionModel()
            }
        }
    }
    
    private func updateSubscriptionModel() {
        entertainmentSubscription = EntertainmentSubscription(streamingPlan: streamingPlan, maxStreams: maxStreams, has4k: has4k)
    }
}

#Preview {
    AddEntertainmentSubscriptionView(entertainmentSubscription: .constant(EntertainmentSubscription(streamingPlan: .basic, maxStreams: 4, has4k: true)))
}
