//
//  PopularMoviesViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

class PopularMoviesViewController: UIViewController {
  
  private let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLabel()
  }
  
  private func configureLabel() {
    view.addSubview(label)
    
    label.font = .preferredFont(forTextStyle: .title2)
    label.textColor = .white
    label.text = "Popular Movies"
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
}
