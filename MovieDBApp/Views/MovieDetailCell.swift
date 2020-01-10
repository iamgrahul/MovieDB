//
//  MovieDetailCell.swift
//  MovieDBApp
//
//  Created by Rahul  on 09/01/20.
//  Copyright © 2020 Agreeya Solutions. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var imageviewMovie: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    
    public static var nib: UINib {
        return UINib(nibName: "MovieDetailCell", bundle: Bundle(for: MovieDetailCell.self))
    }
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD MMM YYYY"
        return dateFormatter
    }()
    
    public var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            self.taglineLabel.text = movie.title
            self.releaseDate.text = MovieDetailCell.dateFormatter.string(from: movie.releaseDate)
            self.imageviewMovie.sd_setImage(with: movie.posterURL) { (image, error, cacheType, url) in
                print(image ?? "abc")
            }
        }
    }
}
