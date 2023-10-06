//
//  ContentView.swift
//  GridSearch
//
//  Created by Paul Huynh on 2023-10-05.
//

/*
 
 {
 "feed": {
 "title": "Top Free Apps",
 "id": "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json",
 "author": {
 "name": "Apple",
 "url": "https://www.apple.com/"
 },
 "links": [
 {
 "self": "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
 }
 ],
 "copyright": "Copyright © 2023 Apple Inc. All rights reserved.",
 "country": "us",
 "icon": "https://www.apple.com/favicon.ico",
 "updated": "Thu, 5 Oct 2023 19:57:28 +0000",
 "results": [
 {
 "artistName": "SNOW Corporation",
 "id": "1577705074",
 "name": "EPIK - AI Photo Editor",
 "releaseDate": "2021-08-14",
 "kind": "apps",
 "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/d9/28/62/d9286279-2a4a-dd7c-a7e7-daefbdc0b249/AppIcon-0-1x_U007emarketing-0-7-0-85-220.png/100x100bb.png",
 "genres": [],
 "url": "https://apps.apple.com/us/app/epik-ai-photo-editor/id1577705074"
 },
 
 */


// https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = GridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200))
                    
                ], spacing: 12, content: {
                    ForEach(viewModel.items, id: \.self) { num in
                        VStack(alignment: .leading) {
                            Spacer()
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                            
                            Text("App title")
                                .font(.system(size: 10, weight: .semibold))
                            Text("Release Date")
                                .font(.system(size: 9, weight: .regular))
                            Text("Copyright")
                                .font(.system(size: 9, weight: .regular))
                        }
                        .padding()
                        .background(Color.red)
                    }
 
                }).padding(.horizontal, 12)
            }.navigationTitle("Grid Search")
        }
    }
}


class GridViewModel: ObservableObject {
//    var feed: Feed
    
    @Published var items = 0..<10
    
    init() {
        
    }
}

struct RSS: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    let title: String
    let id: String
    let results: [Result]
}

struct Result: Decodable {
    let artistName: String
    let id: String
    let name: String
    let rleaseDate: String
    let kind: String
    let artworkUrl100: String
    let genres: String
    let url: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

