

//  IDTrackManager.swift
//  APITeachHear
//
//  Created by Diego Castro on 14/02/22.
//

import Foundation
import SwiftUI


struct ResultsList : View {
    @EnvironmentObject var shared: IDTrackManager
    
    var body: some View {
        
        ZStack {
          
            if shared.listAppear == true {
                if shared.songProperties?.filter {$0.lyrics != nil && $0.lyrics != "" }.count ?? 0 > 0 {
                    let filteredInfo = shared.songProperties!.filter{ $0.lyrics != nil && $0.lyrics != ""}
                List{
                    
                    ForEach (0..<filteredInfo.count-1, id: \.self) { index in
                        
                        NavigationLink {
                            //Check if the lyrics of the song are available
   
                            LyricsContentView(displayedFinalLyrics: filteredInfo[index].lyrics ?? "No lyrics available", displayedFinalTittle: filteredInfo[index].title)
                                
                            
                        } label: {
                            
                         
                            Text("\(filteredInfo[index].title)")
                        
                            
                            
                        }
                        
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
                .ignoresSafeArea()
                
            
            }
        }
    }
}
}
