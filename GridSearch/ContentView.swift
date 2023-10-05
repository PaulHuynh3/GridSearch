//
//  ContentView.swift
//  GridSearch
//
//  Created by Paul Huynh on 2023-10-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.fixed(100)),
                    GridItem(.fixed(100)),
                    GridItem(.fixed(100))
                ], content: {
                    ForEach(0...20, id: \.self) { num in
                        HStack {
                            Spacer()
                            Text("\(num)")
                            Spacer()
                        }
                        .padding()
                        .background(Color.red)
                    }
 

                })
            }.navigationTitle("Grid Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
