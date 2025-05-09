//
//  AddRepView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftUI

struct AddRepView: View {
    @Environment(\.modelContext) var modelContext
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var repCountString: String = ""
    @State private var selectedType: RepType = .pushups
    let today = Date()
    
    private var repCount: Int {
        return Int(repCountString) ?? 0
    }
    
    var body: some View {
        HStack {
            Picker("Exercise Type", selection: $selectedType) {
                ForEach(RepType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            
            Spacer()
            
            TextField("Reps", text: $repCountString)
                .frame(width: 80)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .focused($isTextFieldFocused)
        }
        .padding(10)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Add") {
                    let entry = RepEntry(count: repCount, type: selectedType)
                    modelContext.insert(entry)
                    try? modelContext.save()
                }
                .disabled(repCount == 0)
                .opacity(repCount == 0 ? 0.5 : 1)
                Spacer()
                Button("Close") {
                    isTextFieldFocused = false
                }
            }
        }
    }
}

#Preview {
    AddRepView()
}
