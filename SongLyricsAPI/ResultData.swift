//
//  finalLyricsData.swift
//  SongLyricsAPI
//
//  Created by Diego Castro on 14/02/22.
//

import Foundation

struct ResultData: Codable {
    let message: FMMessage
   
}

struct FMMessage: Codable {
    let header: FHeader
    let body: FBBody
}

struct FBBody: Codable {
    let lyrics: Lyrics
}

struct FHeader: Codable {
    let status_code: Int
}

struct Lyrics: Codable {
    let lyrics_body: String
}
