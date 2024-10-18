//
//  CastMemberCell.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 18/10/24.
//

import UIKit

class CastMemberCell: UICollectionViewCell {

  @IBOutlet weak var avatarView: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    avatarView.layer.cornerRadius = 45
    avatarView.clipsToBounds = true
    }

}
