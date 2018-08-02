//
//  MoviesController.swift
//  Movies
//
//  Created by Sam Bryson on 8/2/18.
//  Copyright © 2018 Sam Bryson. All rights reserved.
//

import Foundation
import UIKit

class MoviesController {
    
    static let shared = MoviesController()
    
    var movies: [Movies] = []
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") // CHECK THIS
    
    func fetchMovies(by title: String, completion: @escaping ([Movies]?) -> Void) {
        
        guard let unwrappedURL = baseURL else {
            print("Broken url")
            completion(nil); return
        }
        
        var urlComponents = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true)
        
        let parameters = ["api_key" : "5e58ed5a6d052f6e4d859bad097ec656", "query": title]    // CHECK THIS
        
        urlComponents?.queryItems = parameters.flatMap { URLQueryItem(name: $0.key, value: $0.value)}
        
        guard let url = urlComponents?.url else { completion(nil); return }
        
        // Perform a network request - where you can build your url
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Bad data task \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data,
                let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let moviesDictionaries = responseDictionary["results"] as? [[String: Any]] else {
                    print("Cannot Serialize JSON")
                    completion(nil)
                    return
            }
            
            let movies = moviesDictionaries.flatMap{ Movies(dictionary: $0) }
            
            self.movies = movies
            completion(movies)
            }.resume()
        
    }
    
    func fetchImageWith(pathComponent: String, completion: @escaping(UIImage?) -> Void) {
        
        let url = URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2/\(pathComponent)")!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error { print (error.localizedDescription) }
            
            guard let data = data,
                let image = UIImage(data: data) else { completion(nil); return }
            
            completion(image)
            
            
            }.resume()
        
    }
    
}

