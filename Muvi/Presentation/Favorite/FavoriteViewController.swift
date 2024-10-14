//
//  FavoriteViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {

    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLabel()
    }
    

    private func configureLabel() {
        view.addSubview(label)
        
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.text = "Favorites Movies"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }


}
