//
//  MovieListView.swift
//  MovieApp
//
//  Created by Jimmy on 4/7/2021.
//

import SwiftUI

struct MovieListView: View {
    @State private var movies = [Movies]()
    
    let dateFormatterGet = DateFormatter()
    
    let dateFormatterPrint = DateFormatter()
    
    let networkController = NetworkController()
    
    var body: some View {
        NavigationView{
            List(movies, id: \.id) { moviesItem in
                if let moviesItem = moviesItem {
                    NavigationLink(destination: MovieDetailView(code: moviesItem.id)) {
                        HStack{
                            UrlImageView(urlString: moviesItem.thumbnail)
                                .frame(width: 80.0, height: 142.0, alignment: .leading)
                            
                            VStack {
                                if moviesItem.rateCount > 0 {
                                    if let rating = moviesItem.rating {
                                        Text("\(String(format: "%.1f", Double.init(rating) / Double.init(moviesItem.rateCount)))")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 50))
                                            .fontWeight(.bold)
                                    }
                                    
                                    
                                } else {
                                    Text("\(String(format: "%.1f",  moviesItem.rateCount))")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 50))
                                        .fontWeight(.bold)
                                    
                                    HStack {
                                        ForEach(0..<5) {_ in
                                            Image(systemName: "star")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                    
                                }
                            }
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(moviesItem.name)
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Image(systemName: "heart")
                                    Text("\(moviesItem.favCount)")
                                        .foregroundColor(.yellow)
                                    Image(systemName: "text.bubble")
                                    Text("\(moviesItem.commentCount)")
                                        .foregroundColor(.yellow)
                                }
                                
                                Text("\(dateFormatterPrint.string(from: dateFormatterGet.date(from: moviesItem.openDate ?? "" ) ?? Date()))")
                            }
                        }
                    }
                }
            }.onAppear(perform: loadData)
        }
        .navigationBarTitleDisplayMode(.automatic)
        
    }
    
    private func loadData() {
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = "E' 'dd' 'MMM' 'yyyy' 'HH:mm:ss"
        
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.dateFormat = "dd' 'MMM' 'yyyy"
        
        networkController.fetchMovies(completionHandler: { (movies) in
            DispatchQueue.main.async {
                self.movies = movies
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.movies = []
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
