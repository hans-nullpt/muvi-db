//
//  MovieDetailViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 17/10/24.
//

import UIKit

enum MovieDetailSection: CaseIterable, Hashable {
  case detail
  case castMember
}

class MovieDetailViewController: UIViewController {
  var id: Int?
  
  typealias MovieDataSource = UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetail>
  
  var collectionView: UICollectionView!
  
  internal var datasource: MovieDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    configureCollectionView()
    configureDataSource()
    
    let data = MovieDetail()
    
    updateCollectionViewData(with: data, for: .detail)
  }
  
}
