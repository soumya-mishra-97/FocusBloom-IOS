//
//  FocusBloom_App.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import SwiftUI

@main
struct FocusBloomApp: App {
    @StateObject private var focusVM = FocusViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let activeMode = focusVM.mode {
                NavigationView {
                    FocusView(viewModel: focusVM, selectedMode: activeMode)
                }
            } else {
                HomeView()
                    .environmentObject(focusVM)
            }
        }
    }
}
