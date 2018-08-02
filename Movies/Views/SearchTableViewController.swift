//
//  SearchTableViewController.swift
//  Movies
//
//  Created by Sam Bryson on 8/2/18.
//  Copyright © 2018 Sam Bryson. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movies: [Movies]? = []
    
    //Actions and Outlets
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text else { return }
        self.view.endEditing(true)
        MoviesController.shared.fetchMovies(by: searchTerm) { (movies) in
            
            DispatchQueue.main.async {
                
                guard let movies = movies else { return }
                self.movies = movies
                self.tableView.reloadData()
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        guard let movies = movies else {return UITableViewCell()}
        
        let movie = movies[indexPath.row]
        cell.updateViews(movies: movie)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieDetailSegue" {
            
            guard let destination = segue.destination as? MovieDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            guard let movies = movies else {return}
            destination.movie = movies[indexPath.row]
            
        }
    }
    
}
