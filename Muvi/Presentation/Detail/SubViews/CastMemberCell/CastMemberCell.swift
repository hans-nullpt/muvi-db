//
//  CastMemberCell.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 18/10/24.
//

import UIKit

class CastMemberCell: UICollectionViewCell {
  static let reusableId: String = "CastMemberCell"
  static func nib() -> UINib {
    UINib(nibName: "CastMemberCell", bundle: nil)
  }
  
  @IBOutlet weak var avatarView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    avatarView.layer.cornerRadius = 45
    avatarView.clipsToBounds = true
    avatarView.layer.borderColor = UIColor.white.cgColor
    avatarView.layer.borderWidth = 1.5
  }
  
  func updateData(with data: ProductionCompanies) {
    nameLabel.text = data.name
    
    if let logo = data.logoPath {
      let url = "https://image.tmdb.org/t/p/w500\(logo)"
      Task {
        avatarView.image = await Helper.downloadImage(from: url) ?? UIImage(systemName: "circle")
      }
    }
  }
  
}
