//
//  ViewController.swift
//  MovieDBApp
//
//  Created by Rahul  on 08/01/20.
//  Copyright © 2020 Agreeya Solutions. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UITableViewController {

    var moviesResponse : MoviesResponse? {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieStore = MovieStore.shared
        movieStore.fetchMovies(from: .nowPlaying, successHandler: { (response) in
            print(response)
            self.moviesResponse = response
        }) { (error) in
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as? MovieDetailCell {
            
            if let movie = moviesResponse?.results[indexPath.row] {
                cell.movie = movie
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesResponse?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let movie = moviesResponse?.results[indexPath.row] {
            
            if let movieDetailVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailVC") as? MovieDetailVC {
                movieDetailVC.movie = movie
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }
    }
}

