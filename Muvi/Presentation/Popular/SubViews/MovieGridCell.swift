//
//  MovieGridCell.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 15/10/24.
//

import UIKit

class MovieGridCell: UICollectionViewCell {
  
  static let reusableId = "MovieGridCell"
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  static func nib() -> UINib { UINib(nibName: reusableId, bundle: nil) }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    imageView.layer.cornerRadius = 4
    imageView.clipsToBounds = true
    
  }
  
  func updateData(with movie: Movie) {
    
    Task {
      imageView.image = (await Helper.downloadImage(from: movie.posterPath ?? "")) ?? UIImage(systemName: "photo.badge.exclamationmark")
    }
    
    imageView.backgroundColor = .lightGray
    titleLabel.text = movie.title
    overviewLabel.text = movie.overview
  }
  
}
