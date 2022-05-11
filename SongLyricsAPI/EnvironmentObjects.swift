//
//  environmentObjects.swift
//  APITeachHear
//
//  Created by Diego Castro on 12/02/22.
//

import Foundation
import SwiftUI

 class EnvironmentObjects : ObservableObject {
//    static var shared = environmentObjects()
    
    @Published var searchInput = ""
    @Published var lyricsOutput : String? = "No lyrics"
     @Published var TrackID : Int? = 0
     init (){
         self.lyricsOutput=lyricsOutput
     }
     @Published var transferedlyrics : String? = ""
    
   public func transference (thelyrics: String?) {
      transferedlyrics = thelyrics
       print ("Transfered \(transferedlyrics)")
 
    }
     
     
}
