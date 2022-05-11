
//  IDTrackManager.swift
//  SongLyricsAPI
//
//  Created by Diego Castro on 14/02/22.
//

import Foundation
import SwiftUI

public class IDTrackManager: ObservableObject {
    private init() { }
    
    static var shared = IDTrackManager()
    
    @Published var listAppear: Bool? = true
    
    @Published var songProperties: [SongInfo]?
    
    
    func fetchData (inputTittlesList: ArraySlice<Track>?, listOfTrackedSongs: ArraySlice<Track>?, listAppearance: Bool) async {
        var counter: Int = 1
   
        songProperties = []
        
        listAppear = listAppearance
    
        
        if listOfTrackedSongs!.count > 1 {
            //This if statement is ment to ckeck if the size of the songs returned by the API is greater than 10
            counter = listOfTrackedSongs!.count-1
            print("Counter", counter)
            
        } else {
            counter = 1
            print("Counter", counter)
        }
        
        for i in 0...counter {
            //ListOfTrackedSongs is an array of arrays, so separate each array  inside the group of arrays.
            let splitElementsInArray = listOfTrackedSongs![i]
     
            songProperties?.append(SongInfo(title: splitElementsInArray.track.track_name, trackID: splitElementsInArray.track.track_id, hasLyrics: splitElementsInArray.track.has_lyrics, songURL: "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=\(splitElementsInArray.track.track_id)&apikey=\(APIkey().apiKey())"))
            print("Counts", songProperties?.count)
            print ("This is I", i)
            
            if songProperties?[songProperties!.count - 1].songURL == nil  {
                //We just make sure that there is something inside the listOfURLs, althoughy I think this is unnecesary since this array was already defined has a list of empty strings.
                songProperties![songProperties!.count - 1].lyrics = "No URL for this song lyrics"
        
                
            } else {
         
                //URL
                if let url = URL(string: songProperties?[i].songURL ?? "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=0&apikey=\(APIkey().apiKey())")
                    
                {
  
                    //With the if statement below we check that we have a valid URL
                    if songProperties?[i].songURL == "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=0&apikey=\(APIkey().apiKey())"  {
                        
                        self.songProperties![i].lyrics = "There was a problem while downloading the lyrics ☹️"
                        
                    } else {
         
                        //URL Session
                        let session = URLSession(configuration: .default)
                        //FEtching task
                        let task = session.dataTask(with: url) { (data, response, error) in
                            //Error handle
                            
                            if error != nil {
                                
                                fatalError("\(String(describing: error?.localizedDescription))")
                            }
                            
                            //Parse JSON to a readable version
                            if let receivedData = data {
               
                                //Decoded
                                if let decodedata = self.decodeJASONData(receivedData: receivedData){
                                    //Convert to usable form
                                    
                                    let lyricsData = self.convertDecodedDataToUsableForm(decodedData: decodedata)
                                    
                                    if lyricsData.statusCode != 200{
                                        
                                        self.songProperties![i].lyrics = "There was a problem while downloading the lyrics ☹️"
                       
                                    } else {
                                        if counter == 1 && i<1 {
                                        //Pass the data to the main view
                                        self.songProperties![i].lyrics = lyricsData.songLyrics
                                        } else if counter == 1 && i>0 {
                                            
                                        }
                                        else {
                                            if i <= self.songProperties!.count-1 {
                                            self.songProperties![i].lyrics = lyricsData.songLyrics
                                            }
                                        }
                       
      
                                    }
                                    
                                    
                                    
                                }
                                
                                
                            }
                        }
                        task.resume()
                    }
                }
                
                
                
            }
        }
        
        
        return
        
    }
    
    private func decodeJASONData (receivedData: Data) -> ResultData? {
        
        //Write a function to decode JSON data
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ResultData.self, from: receivedData)
            
            
            return decodedData
        } catch {
            
            return nil
        }
        
    }
    private func convertDecodedDataToUsableForm (decodedData: ResultData) ->
    ResultModel {
        
        let songData = ResultModel(statusCode: decodedData.message.header.status_code, songLyrics: decodedData.message.body.lyrics.lyrics_body)
        
        return songData
    }
    
    
    
}
