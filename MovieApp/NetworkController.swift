//
//  NetworkController.swift
//  MovieApp
//
//  Created by Jimmy on 4/7/2021.
//

import Foundation
import SwiftUI

class NetworkController {
    func fetchMovies(completionHandler: @escaping ([Movies]) -> (),
                     errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: "https://api.hkmovie6.com/hkm/movies?type=showing")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Server error encountered
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode < 300 else {
                // Client error encountered
                errorHandler(nil)
                return
            }
            
            guard let data = data, let movies =
                    try? JSONDecoder().decode([Movies].self, from: data) else {
                errorHandler(nil)
                return
            }
            
            // Call our completion handler with our news
            completionHandler(movies)
        }
        
        task.resume()
    }
    
    func fetchMovie(id: Int64, completionHandler: @escaping (Movies) -> (),
                    errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: "https://api.hkmovie6.com/hkm/movies/\(id)")!
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Server error encountered
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode < 300 else {
                // Client error encountered
                errorHandler(nil)
                return
            }
            
            guard let data = data, let movie =
                    try? JSONDecoder().decode(Movies.self, from: data) else {
                errorHandler(nil)
                return
            }
            
            print("Data2: \(movie)")
            
            // Call our completion handler with our news
            completionHandler(movie)
        }
        
        task.resume()
    }
}
