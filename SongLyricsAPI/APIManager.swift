//
//  APIManager.swift
//  SongLyricsAPI
//
//  Created by Diego Castro on 12/02/22.
//

import Foundation
import SwiftUI

public class APIManager: ObservableObject {
    
    @Published var receivedTittlesList : ArraySlice<Track>?
    @Published var receivedTittles : ArraySlice<Track>?
    @Published var listAppearance : Bool = false
    @Published var tracksList : ArraySlice<Track>?
    {
        didSet{
            Task{
                await IDTrackManager.shared.fetchData(inputTittlesList: receivedTittlesList, listOfTrackedSongs: tracksList, listAppearance: listAppearance)
            }
        }
    }
    
    public func fetchData (userInput: String) async {

        let firstDataURL = "https://api.musixmatch.com/ws/1.1/track.search?q=\(userInput)&apikey=\(APIkey().apiKey())"
        
        if firstDataURL == "https://api.musixmatch.com/ws/1.1/track.search?q=xoloitzcuintle&apikey=\(APIkey().apiKey())" {
            
            listAppearance = false
            
        } else {
            listAppearance = true
        }
        
        //URL
        if let url = URL(string: firstDataURL) {
 
            
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
                    if let decodedata = self.decodeJASONData(receivedData: receivedData) {
             
                        //                        --------------------------------------------------
                        //This section is usefull because prevents a crash in case of user misspelling of words, but needs further work
                        if decodedata.message.body.track_list.count <= 1 {
               
                        } else {
                   
                            //Convert to usable form
                            let someData =
                            self.convertDecodedDataToUsableForm(decodedData: decodedata)
                            self.passData(firstData: someData)
                        }
                        //                        --------------------------------------------------
                        
                    }
                    
                    
                }
            }
            task.resume()
        }
        
        return
    }
    
    private func decodeJASONData (receivedData: Data) -> FirstData? {
        
        //Write a function to decode JSON data
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(FirstData.self, from: receivedData)
            //Se toma el valor almacenado en reveivedData y se pasa por el struct lyricsData
            
            return decodedData
        } catch {
            return nil
        }
        
    }
    private func convertDecodedDataToUsableForm (decodedData: FirstData) -> FirstDataModel {
        let firstDataBody = FirstDataModel(statusCode: decodedData.message.header.status_code, track_list: decodedData.message.body.track_list[0...decodedData.message.body.track_list.count-1])
        
        return firstDataBody
        
    }
    
    
    private func passData(firstData: FirstDataModel) {
        tracksList = firstData.track_list
        
    }
    
}
