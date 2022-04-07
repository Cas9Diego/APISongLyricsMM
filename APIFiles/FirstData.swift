//
//  lyricsData.swift
//  APITeachHear
//
//  Created by Diego Castro on 12/02/22.
//

import Foundation

struct FirstData: Codable {
    let message: MMessage
   
}

struct MMessage: Codable {
    let header: Header
    let body: BBody
}

struct BBody: Codable {
    let track_list: [Track]
}

struct Header: Codable {
    let status_code: Int
}

struct Track: Codable {
    let track: Tracks
}

struct Tracks: Codable {
    let track_id: Int
    let has_lyrics: Int
    let track_name : String
}
