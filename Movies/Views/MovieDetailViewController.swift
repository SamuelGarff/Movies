//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Sam Bryson on 8/2/18.
//  Copyright © 2018 Sam Bryson. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movies?
    
    
    // Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    func updateViews(movie: Movies) {
        
//        self.titleLabel.text = movie.title
        self.navigationItem.title = movie.title
        self.descriptionLabel.text = movie.overview
        self.ratingLabel.text = "\(movie.vote_Average)"
        
        MoviesController.shared.fetchImageWith(pathComponent: movie.imageEndpoint) { (image) in
            
            DispatchQueue.main.async {
                
                self.imageLabel.image = image
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let movie = movie else {return}
        updateViews(movie: movie)
    }
}
