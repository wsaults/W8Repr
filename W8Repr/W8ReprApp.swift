//
//  W8ReprApp.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftUI

@main
struct W8ReprApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [RepEntry.self])
    }
}
