//
//  ContactFetchAppApp.swift
//  ContactFetchApp
//
//  Created by Igor Malyarov on 29.03.2023.
//

import SwiftUI

@main
struct ContactFetchAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
