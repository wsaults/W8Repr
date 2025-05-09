//
//  LogbookView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftUI
import SwiftData

struct LogbookView: View {
    var entries: [RepEntry]
    @State private var showingAddWeight = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "No Weight Entries",
                        systemImage: "book.closed",
                        description: Text("Add your first weight entry to start tracking your progress")
                    )
                } else {
                    HistorySectionView(entries: entries)
                }
            }
            .navigationTitle("Logbook")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddWeight = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddWeight) {
                AddRepView()
            }
        }
    }
}

#Preview {
    LogbookView(entries: RepEntry.shortSampleData)
}
