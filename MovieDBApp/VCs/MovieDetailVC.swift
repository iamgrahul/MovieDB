//
//  MovieDetailVC.swift
//  MovieDBApp
//
//  Created by Rahul  on 09/01/20.
//  Copyright © 2020 Agreeya Solutions. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var textviewMovieDescription: UITextView!
    @IBOutlet var otherRelatedMoviesCV: UICollectionView!
    @IBOutlet var labelMovieReleaseDate: UILabel!
    @IBOutlet var posterImageview: UIImageView!
    @IBOutlet var labelMovieTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getSimilarMovies()
    }
    
    public var movie: Movie!
    var similarMoviesResponse : MoviesResponse? {
        
        didSet {
            self.otherRelatedMoviesCV.reloadData()
        }
    }
    
    func setupView() {
        
        self.labelMovieTitle.text = movie.title
        self.labelMovieReleaseDate.text = MovieDetailCell.dateFormatter.string(from: movie.releaseDate)
        self.posterImageview.sd_setImage(with: movie.posterURL) { (image, error, cacheType, url) in
            print(image ?? "BlankImage")
        }
        self.textviewMovieDescription.text = movie.overview
    }
    
    func getSimilarMovies()  {
        let movieStore = MovieStore.shared
        movieStore.fetchSimilarMovies(from: .similar, movie: movie, successHandler: { (response) in
            self.similarMoviesResponse = response
        }) { (error) in
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMoviesResponse?.results.count ?? 0
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherMovieCVC", for: indexPath as IndexPath) as? OtherMovieCVC {
            if let movie = similarMoviesResponse?.results[indexPath.row] {
                cell.movie = movie
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if let movie = similarMoviesResponse?.results[indexPath.row] {
            
            if let movieDetailVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailVC") as? MovieDetailVC {
                movieDetailVC.movie = movie
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }
    }
}

