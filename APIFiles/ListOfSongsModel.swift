//
//  ListOfSongsModel.swift
//  APITeachHear
//
//  Created by Diego Castro on 16/02/22.
//

import Foundation
struct ListOfSongsModel {
    let statusCode: Int
    let track_id: Int
    let has_lyrics: Int
    let track_list : ArraySlice<Track>
    
}
