//
//  MovieCell.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reusabledId: String = "MovieCell"
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(with data: Movie) {
        print("Movie Name: ", data.title ?? "No Title")
        print("Movie Poster: ", data.posterPath ?? "No Poster")
        print("Movie backdrop: ", data.backdropPath ?? "No backdrop")
        
        if let posterPath = data.posterPath {
            let url = "https://image.tmdb.org/t/p/w500\(posterPath)"
            Task {
                imageView.image = await Helper.downloadImage(from: url) ?? UIImage(systemName: "circle")
            }
        }
    }
    
    private func configureImage() {
        addSubview(imageView)
        
        imageView.frame = bounds
    }
    
}
