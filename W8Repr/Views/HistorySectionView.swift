//
//  HistorySectionView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftUI

struct HistorySectionView: View {
    @Environment(\.modelContext) private var modelContext
    let entries: [RepEntry]
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter
    }()
    
    var body: some View {
        List {
            ForEach(entries) { entry in
                HStack {
                    Text(entry.date, formatter: Self.dateFormatter)
                    Spacer()
                    HStack(spacing: 4) {
//                        Text(entry.count)
//                        .fontWeight(.bold)
//                        
//                        Text(entry.type.rawValue)
                    }
                }
                .padding(.vertical, 8)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        deleteEntry(entry)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    deleteEntry(entries[index])
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if !entries.isEmpty {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteEntry(_ entry: RepEntry) {
        withAnimation {
            modelContext.delete(entry)
            try? modelContext.save()
        }
    }
}

#Preview {
    HistorySectionView(entries: RepEntry.shortSampleData)
}
