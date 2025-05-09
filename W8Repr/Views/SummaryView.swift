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
    
    private var last7DaysEntries: [RepEntry] {
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: .now)!
        return entries.filter { $0.date >= sevenDaysAgo }
    }
    
    private var typeGroupedData: [(type: RepType, count: Int)] {
        Dictionary(grouping: last7DaysEntries, by: \.type)
            .map { (type: $0.key, count: $0.value.reduce(0) { $0 + $1.count }) }
            .sorted { $0.count > $1.count }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "Start Tracking!",
                        systemImage: "person.badge.plus",
                        description: Text("Enter your reps below.")
                    )
                } else {
                    let totalReps = last7DaysEntries.reduce(0) { $0 + $1.count }
                    Text("Total Reps: \(totalReps)")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    Chart(typeGroupedData, id: \.type) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.4),
                            angularInset: 1.5
                        )
                        .cornerRadius(3)
                        .foregroundStyle(by: .value("Type", item.type.rawValue.capitalized))
                        .annotation(position: .overlay) {
                            VStack {
                                Text(item.type.rawValue.capitalized)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                Text("\(item.count)")
                                    .font(.caption2)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    .chartLegend(position: .bottom, alignment: .center)
                    
                    Text("Last 7 Days")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
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
