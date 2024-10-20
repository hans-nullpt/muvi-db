//
//  MovieDetailBackgroundCell.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 18/10/24.
//

import UIKit

class MovieDetailBackgroundCell: UICollectionViewCell {
  static let reusableId = "MovieDetailBackgroundCell"
  static func nib() -> UINib {
    UINib(nibName: "MovieDetailBackgroundCell", bundle: nil)
  }

  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var runtimeLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var gradientView: UIView!
  
  var gradientLayer: CAGradientLayer!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    
    gradientLayer.colors = [
      UIColor.clear.cgColor,
      UIColor.systemBackground.cgColor
    ]
    
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    
    gradientLayer.locations = [0, 0.75]
    gradientView.layer.insertSublayer(gradientLayer, at: 0)
    
  }
  
  override func layoutSubviews() {
    gradientLayer.frame = gradientView.bounds
  }
  
  func updateData(with data: MovieDetail) {
    if let posterPath = data.posterPath {
      let url = "https://image.tmdb.org/t/p/w500\(posterPath)"
      Task {
        backdropImageView.image = await Helper.downloadImage(from: url) ?? UIImage(systemName: "circle")
      }
    }
    
    titleLabel.text = data.title
    runtimeLabel.text = convertRuntimeToHumanReadable(from: data.runtime ?? 0)
    
    let genres = (data.genres ?? []).map<String>({ $0.name ?? "" }).joined(separator: ", ")
    genresLabel.text = genres
    
    overviewLabel.text = data.overview
  }
  
  func convertRuntimeToHumanReadable(from runtime: Int) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    formatter.allowedUnits = [.hour, .minute]

    return formatter.string(from: TimeInterval(runtime * 60))
  }

}
