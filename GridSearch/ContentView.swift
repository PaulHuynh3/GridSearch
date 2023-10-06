//
//  ContentView.swift
//  GridSearch
//
//  Created by Paul Huynh on 2023-10-05.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    //Need this objeserved object when using ViewModels for SwiftUI
    @ObservedObject var viewModel = GridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top)
                    
                ], alignment: .leading, spacing: 16, content: {
                    ForEach(viewModel.results, id: \.self) { res in
                        AppInfo(res: res)
                        
                    }
                }).padding(.horizontal, 12)
            }.navigationTitle("Grid Search")
        }
    }
}


struct AppInfo: View {
    var res: Result
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(URL(string: res.artworkUrl100))
                .resizable()
                .scaledToFit()
                .cornerRadius(22)
            
            Text(res.name)
                .font(.system(size: 10, weight: .semibold))
                .padding(.top, 4)
            Text(res.releaseDate)
                .font(.system(size: 9, weight: .regular))
            Text(res.artistName)
                .font(.system(size: 9, weight: .regular))
        }
    }
}

class GridViewModel: ObservableObject {

    // Note - We need this published because when it gets set
    // it will tell the views to redraw itself else users wont see the update.
    @Published var results = [Result]()
    
    init() {
        //Best place to call a service call is INIT()
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

