//
//  ContentView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingInitialDataToast = false
    
    #if targetEnvironment(simulator)
    private var entries: [RepEntry] = RepEntry.shortSampleData
    #else
    @Query(
        sort: [SortDescriptor(\RepEntry.date, order: .reverse)]
    ) private var entries: [RepEntry]
    #endif
    
    var body: some View {
        TabView {
            SummaryView(entries: entries)
                .tabItem {
                    Label("Summary", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            LogbookView(entries: entries)
                .tabItem {
                    Label("Logbook", systemImage: "book")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            if entries.isEmpty {
                RepEntry.shortSampleData.forEach { entry in
                    modelContext.insert(entry)
                }
                try? modelContext.save()
                withAnimation {
                    showingInitialDataToast = true
                }
            }
        }
        .toast(
            isPresented: $showingInitialDataToast,
            message: "Sample data added. Feel free to delete and add your own entries!",
            systemImage: "info.circle"
        )
    }
}
