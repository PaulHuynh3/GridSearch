//
//  ContentView.swift
//  GridSearch
//
//  Created by Paul Huynh on 2023-10-05.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = GridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 125, maximum: 200), spacing: 12, alignment: .top),
                    GridItem(.flexible(minimum: 125, maximum: 200), spacing: 12, alignment: .top),
                    GridItem(.flexible(minimum: 125, maximum: 200), alignment: .top)
                    
                ], spacing: 12, content: {
                    ForEach(viewModel.results, id: \.self) { res in
                        VStack(alignment: .leading) {
                            Spacer()
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                            
                            Text(res.name)
                                .font(.system(size: 10, weight: .semibold))
                            Text(res.releaseDate)
                                .font(.system(size: 9, weight: .regular))
                            Text(res.artistName)
                                .font(.system(size: 9, weight: .regular))
                        }
                        .padding(.horizontal)
                    }
                }).padding(.horizontal, 12)
            }.navigationTitle("Grid Search")
        }
    }
}


class GridViewModel: ObservableObject {
    @Published var items = 0..<10
    @Published var results = [Result]()
    
    init() {
        
        URLSession.shared.dataTask(with: URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json")!) { (data, res, err) in
            
            guard let data = data else { return }
            
            do {
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                self.results = rss.feed.results
            } catch {
                print("Failed to decode")
            }
        }.resume()
        
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

struct Result: Decodable, Hashable {
    let artistName: String
    let id: String
    let name: String
    let releaseDate: String
    let kind: String
    let artworkUrl100: String
    let url: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

