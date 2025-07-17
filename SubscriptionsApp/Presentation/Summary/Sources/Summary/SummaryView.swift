//
//  SummaryView.swift
//  Summary
//
//  Created by Tomasz Wojtyniak on 09/07/2025.
//

import SwiftUI
import SharedUtilities

struct SummaryView: View {
    
    @State private var dataModel = SummaryDataModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if dataModel.costPerType.isEmpty {
                    ContentUnavailableView("summary.subscription.data.unavailable".localized(.module), systemImage: "exclamationmark.shield.fill")
                } else {
                    List {
                        ForEach(Array(dataModel.costPerType.keys.sorted(by: { $0.rawValue < $1.rawValue })), id: \.self) { type in
                            let total = dataModel.costPerType[type] ?? 0
                            HStack {
                                Text(type.rawValue)
                                Spacer()
                                Text(total, format: .currency(code: "EUR"))
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .refreshable {
                        await self.dataModel.getSubscriptionsData()
                    }
                }
            }
            .navigationTitle("summary.navigation.title".localized(.module))
            .alert("error.title".localized(.module), isPresented: $dataModel.isShowingErrorAlert, actions: {
                Button("OK", role: .cancel) { }
            })
        }
    }
}

#Preview {
    SummaryView()
}
