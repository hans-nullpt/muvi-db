//
//  FavoriteMovieCell.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 21/10/24.
//

import UIKit

protocol FavoriteMovieCellDelegate {
  func didRemoveItem()
}

class FavoriteMovieCell: UITableViewCell {
  static let reusableId: String = "FavoriteMovieCell"
  static func nib() -> UINib {
    UINib(nibName: "FavoriteMovieCell", bundle: nil)
  }
  
  var movie: Movie!
  var vm: FavoriteMovieViewModel!
  var delegate: FavoriteMovieCellDelegate?
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseYearLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBAction func removeFavoriteButton(_ sender: Any) {
    vm?.removeFromFavorite(movie)
    delegate?.didRemoveItem()
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func updateData(with movie: Movie) {
    titleLabel.text = movie.title
    releaseYearLabel.text = movie.releaseDate
    
    genreLabel.text = ""
    
    if let backdropPath = movie.backdropPath {
      let url = "https://image.tmdb.org/t/p/w500\(backdropPath)"
      Task {
        backdropImageView.image = await Helper.downloadImage(from: url) ?? UIImage(systemName: "circle")
      }
    }
  }
    
}
