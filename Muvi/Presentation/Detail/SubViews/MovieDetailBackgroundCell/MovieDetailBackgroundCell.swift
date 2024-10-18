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

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

}
