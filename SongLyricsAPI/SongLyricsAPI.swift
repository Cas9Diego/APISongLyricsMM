//
//  APITeachHearApp.swift
//  SongLyricsAPI
//
//  Created by Diego Castro on 12/02/22.
//

import SwiftUI

@main
struct SongLyricsAPI: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IDTrackManager.shared)
          
        }
    }
}
