//
//  APITeachHearApp.swift
//  APITeachHear
//
//  Created by Diego Castro on 12/02/22.
//

import SwiftUI

@main
struct APITeachHearApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IDTrackManager.shared)
          
        }
    }
}
