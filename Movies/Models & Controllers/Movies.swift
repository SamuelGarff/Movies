//
//  Movies.swift
//  Movies
//
//  Created by Sam Bryson on 8/2/18.
//  Copyright © 2018 Sam Bryson. All rights reserved.
//

import Foundation
import UIKit

struct Movies {
    
    private let titleKey = "title"
    private let overviewKey = "overview"
    private let vote_AverageKey = "vote_average"
    private let imageKey = "poster_path"
    
    
    // Properties
    
    let title: String
    let overview: String
    let vote_Average: Double
    var image: UIImage?
    let imageEndpoint: String
    var imageURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2/\(imageEndpoint)")   //CHECK THIS
    }
    
    // Failable
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary[titleKey] as? String,
            let overview = dictionary[overviewKey] as? String,
            let vote_Average = dictionary[vote_AverageKey] as? Double,
            let imageEndpoint = dictionary[imageKey] as? String else { return nil }
        
        self.title = title
        self.overview = overview
        self.vote_Average = vote_Average
        self.imageEndpoint = imageEndpoint
        
    }
}
