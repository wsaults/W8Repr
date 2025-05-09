//
//  SummaryView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import Charts
import SwiftData
import SwiftUI

struct SummaryView: View {
    var entries: [RepEntry]
    
    var body: some View {
        NavigationStack {
            VStack {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "Start Tracking!",
                        systemImage: "person.badge.plus",
                        description: Text("Tap the + button to track your weight")
                    )
                }
                
                Spacer()
                
                AddRepView()
                    .padding(.bottom)
            }
            .background(.gray.opacity(0.1))
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

@available(iOS 18, macOS 15, *)
#Preview(traits: .modifier(EntriesPreview())) {
    @Previewable @Query var entries: [RepEntry]
    
    SummaryView(entries: RepEntry.shortSampleData)
}

struct EntriesPreview: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: RepEntry.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let examples = RepEntry.shortSampleData
        examples.forEach { example in
            container.mainContext.insert(example)
        }
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}
