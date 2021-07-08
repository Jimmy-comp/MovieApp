//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Jimmy on 4/7/2021.
//

import SwiftUI

struct MovieDetailView: View {
    var code: Int64
    
    @State private var movie: Movies?
    
    @State private var isExpanded: Bool = false
    
    let networkController = NetworkController()
    
    @State private var numberOfImages = 0
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    let dateFormatterGet = DateFormatter()
    
    let dateFormatterPrint = DateFormatter()
    
    @State private var date = ""
    
    @State private var currentIndex = 0
    
    func next() {
        withAnimation {
            currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
        }
    }
    
    var body: some View {
        VStack {
            if let movie = movie {
                
                TabView(selection: $currentIndex){
                    if let screenShots = movie.screenShots {
                        if screenShots.count == 0 {
                            UrlImageView(urlString: "")
                        } else {
                            ForEach(0..<screenShots.count) { num in
                                UrlImageView(urlString: screenShots[num])
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .onReceive(timer, perform: { _ in
                    next()
                })
                
                
                HStack {
                    VStack {
                        if movie.rateCount > 0 {
                            if let rating = movie.rating {
                                Text("\(String(format: "%.1f", Double.init(rating) / Double.init(movie.rateCount)))")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 50))
                                    .fontWeight(.bold)
                                
                                HStack {
                                    switch Double.init(rating) / Double.init(movie.rateCount) {
                                    case 0..<1:
                                        Image(systemName: "star.leadinghalf.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                        ForEach(0..<4) {_ in
                                            Image(systemName: "star")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                    case 1..<2:
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                        Image(systemName: "star.leadinghalf.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                        ForEach(0..<3) {_ in
                                            Image(systemName: "star")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                    case 2..<3:
                                        ForEach(0..<2) {_ in
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                        Image(systemName: "star.leadinghalf.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                        ForEach(0..<2) {_ in
                                            Image(systemName: "star")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                    case 3..<4:
                                        ForEach(0..<3) {_ in
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                        Image(systemName: "star.leadinghalf.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                        Image(systemName: "star")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                    case 4..<5:
                                        ForEach(0..<4) {_ in
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                        Image(systemName: "star.leadinghalf.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                    default:
                                        ForEach(0..<5) {_ in
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 8))
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                }
                            }
                            
                            
                        } else {
                            Text("\(String(format: "%.1f",  movie.rateCount))")
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
                        Text(movie.name )
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "heart")
                            Text("\(movie.favCount )")
                                .foregroundColor(.yellow)
                            Image(systemName: "text.bubble")
                            Text("\(movie.commentCount )")
                                .foregroundColor(.yellow)
                        }
                        
                        
                        HStack {
                            Text("\(date)")
                                .font(.system(size: 12))
                            
                            if movie.duration != nil {
                                Text(" | " + "\(movie.duration ?? 0) mins")
                                    .font(.system(size: 12))
                            }
                            
                            if movie.infoDict.Category != nil {
                                Text(" | " + "Level: \(movie.infoDict.Category ?? "")")
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    .padding(.leading, 20)
                }
                
                if movie.synopsis != nil {
                    Text(movie.synopsis ?? "")
                        .lineLimit(isExpanded ? nil : 3)
                        .padding(.top, 15)
                        .font(.system(size: 15))
                    
                    Button( action: {
                        isExpanded.toggle()
                    }) {
                        HStack {
                            Text(isExpanded ? "Less" : "More")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        
                    }
                    .frame(width: 100, alignment: .leading)
                }
                
                List {
                    if movie.infoDict.Director != nil {
                        HStack {
                            Text("Director")
                                .frame(width: 80, alignment: .leading)
                            Text(movie.infoDict.Director ?? "")
                        }
                    }
                    
                    if movie.infoDict.Cast != nil {
                        HStack {
                            Text("Cast")
                                .frame(width: 80, alignment: .leading)
                            Text(movie.infoDict.Cast ?? "")
                            
                        }
                    }
                    
                    if movie.infoDict.Category != nil {
                        HStack {
                            Text("Category")
                                .frame(width: 80, alignment: .leading)
                            Text(movie.infoDict.Category ?? "")
                            
                        }
                    }
                    
                    if movie.infoDict.Genre != nil {
                        HStack {
                            Text("Genre")
                                .frame(width: 80, alignment: .leading)
                            Text(movie.infoDict.Genre ?? "")
                        }
                    }
                    
                    if movie.language != nil {
                        HStack {
                            Text("Language")
                                .frame(width: 80, alignment: .leading)
                            Text(movie.language ?? "")
                            
                        }
                    }
                }
                
            }
            
        }
        .padding(0)
        .onAppear(perform: loadData)
        
    }
    
    private func loadData() {
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = "E' 'dd' 'MMM' 'yyyy' 'HH:mm:ss"
        
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.dateFormat = "dd' 'MMM' 'yyyy"
        
        networkController.fetchMovie(id: code , completionHandler: { (movie) in
            DispatchQueue.main.async {
                self.movie = movie
                if let screenShots = movie.screenShots {
                    self.numberOfImages = screenShots.count
                }
                if let date = movie.openDate {
                    self.date = dateFormatterPrint.string(from: dateFormatterGet.date(from: date) ?? Date())
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                print(error!)
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        MovieDetailView()
        EmptyView()
    }
}
