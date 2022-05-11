//
//  LyricsContentView.swift
//  SongLyricsAPI
//
//  Created by Diego Castro on 17/02/22.
//

import SwiftUI

struct LyricsContentView: View {
  let displayedFinalLyrics: String
  let displayedFinalTittle: String
    var body: some View {
   
        VStack{
            Text(displayedFinalTittle)
                .font(.subheadline.weight(.bold))
                .padding(.all)
            
        Text(displayedFinalLyrics)
                .padding(.all)
            Spacer(minLength: .leastNonzeroMagnitude)
               
        }  
        
    }
}

struct LyricsContentView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsContentView(displayedFinalLyrics: "No lyrics", displayedFinalTittle: "No tittle")
    }
}
