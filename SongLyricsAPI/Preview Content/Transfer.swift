//
//  Transfer.swift
//  APITeachHear
//
//  Created by Diego Castro on 15/02/22.
//

import Foundation
import SwiftUI

public class Transfer: ObservableObject {
     
    @Published var thisAreLyrics : finalLyricsModel? = finalLyricsModel(statusCode: 1, songLyrics: "No song lyrics"){
         didSet{
             updatelyrics(statusCode: thisAreLyrics!.statusCode, songLyrics: thisAreLyrics!.songLyrics)
             
         }
     }
     func updatelyrics (statusCode: Int, songLyrics: String) {
     thisAreLyrics = finalLyricsModel(statusCode: statusCode, songLyrics: songLyrics)
         
     }
}
