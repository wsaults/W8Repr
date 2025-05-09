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
    @State private var showingAddRep = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "No Reps Logged",
                        systemImage: "book.closed",
                        description: Text("Add your first rep entry to start tracking your progress")
                    )
                } else {
                    HistorySectionView(entries: entries)
                }
            }
            .navigationTitle("Logbook")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddRep = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRep) {
                AddRepView()
            }
        }
    }
}

#Preview {
    LogbookView(entries: RepEntry.shortSampleData)
}
