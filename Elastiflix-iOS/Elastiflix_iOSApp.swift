//
//  Elastiflix_iOSApp.swift
//  Elastiflix-iOS
//
//  Created by David Hope on 7/25/23.
//

import SwiftUI

@main
struct Elastiflix_iOSApp: App {
    init() {
        // Initialize the TraceManager
        _ = TraceManager.shared
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
