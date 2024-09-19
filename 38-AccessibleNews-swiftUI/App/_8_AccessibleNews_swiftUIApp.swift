//
//  _8_AccessibleNews_swiftUIApp.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import SwiftUI

@main
struct _8_AccessibleNews_swiftUIApp: App {
    @StateObject var newsModel = MainPageViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(newsModel)
        }
    }
}
