//
//  AddWeightView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftUI

struct AddRepView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var repCountString: String = ""
    @State private var selectedType: RepType = .pushups
    let today = Date()
    
    private var repCount: Int {
        return Int(repCountString) ?? 0
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            
            HStack {
                Picker("Exercise Type", selection: $selectedType) {
                    ForEach(RepType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                
                TextField("Reps", text: $repCountString)
                    .frame(width: 100)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            Button {
                let entry = RepEntry(count: repCount, type: selectedType)
                modelContext.insert(entry)
                try? modelContext.save()
            } label: {
                Text("Add")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .disabled(repCount == 0)
        }
        .padding()
    }
}

#Preview {
    AddRepView()
}
