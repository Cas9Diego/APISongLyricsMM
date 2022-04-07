//
//  ContentView.swift
//  APITeachHear
//
//  Created by Diego Castro on 12/02/22.
//

import SwiftUI

struct ContentView: View {
    @State var userInput : String = ""

  
    @StateObject var APIMManager = APIManager()
    @EnvironmentObject var IDTTrackManager: IDTrackManager
 
    
    var body: some View {
        NavigationView{
        VStack{
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(uiColor: .systemGray2))
                
            TextField("Type artist and song name", text: $userInput)
                .disableAutocorrection(true)
                
                if !userInput.isEmpty {
                    Button {
                        userInput = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(uiColor: .systemGray2))
                    }
                    .padding(.trailing, 8)
                }
                
            Spacer()
            }
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(.infinity)
            .padding(.horizontal, 20)
            
            Spacer()
            
            ResultsList()

            
          Spacer()
                .padding()
        

        }.navigationBarTitle("Home")
        
                .onChange(of: userInput, perform:  { value in
            let pronnedInput = userInput.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
            if userInput == "" {
                Task {
                 await  IDTTrackManager.listAppear = false
                }
               

            } else {
                Task {
                
        await APIMManager.fetchData(userInput: pronnedInput!)
            }
            }
           
        })
        }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
