//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Sam Bryson on 8/2/18.
//  Copyright © 2018 Sam Bryson. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // Actions and Outlets
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var movie: Movies? {
        
        didSet {
            
            guard let movies = movie else { return }
            updateViews(movies: movies)
            
        }
    }
    
    
    func updateViews(movies: Movies) {
        
//        self.movieTitle.text = movies.title
//        self.movieDescription.text = movies.overview
//        self.movieRating.text = "\(movies.vote_Average)"
        
        MoviesController.shared.fetchImageWith(pathComponent: movies.imageEndpoint) { (image) in
            
            DispatchQueue.main.async {
                
                self.movieImage.image = image
            }
        }
    }
}
