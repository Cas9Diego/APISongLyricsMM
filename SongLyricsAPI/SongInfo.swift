//
//  SongInfo.swift
//  SongLyricsAPI
//
//  Created by Diego Castro on 28/02/22.
//

import Foundation

struct SongInfo {
    var id = UUID()
    var title: String
    var trackID: Int
    var hasLyrics: Int
    var songURL: String
    var lyrics: String? = nil
    
    }

