//
//  OtherMovieCVC.swift
//  MovieDBApp
//
//  Created by Rahul  on 09/01/20.
//  Copyright © 2020 Agreeya Solutions. All rights reserved.
//

import UIKit

class OtherMovieCVC: UICollectionViewCell {

    @IBOutlet weak var imageviewPoster: UIImageView!
    
    public var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            imageviewPoster.image = UIImage()
            self.imageviewPoster.sd_setImage(with: movie.posterURL) { (image, error, cacheType, url) in
                print(image ?? "BlankPoster")
                self.imageviewPoster.contentMode = .scaleAspectFit
            }
        }
    }

}
