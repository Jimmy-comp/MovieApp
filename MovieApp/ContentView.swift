//
//  ContentView.swift
//  MovieApp
//
//  Created by Jimmy on 4/7/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListView().tabItem {
                Image(systemName: "film")
                Text("Movies")
            }
            
            //            SettingView().tabItem {
            //                Image(systemName: "slider.horizontal.3")
            //                Text("Settings")
            //            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
