//
//  PopularMoviesViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit
import RxSwift

class PopularMoviesViewController: UIViewController {
  typealias MovieDataSource = UICollectionViewDiffableDataSource<Int, Movie>
  
  internal var collectionView: UICollectionView!
  internal var datasource: MovieDataSource!
  
  internal let viewModel: PopularMovieListViewModel
  internal let disposeBag = DisposeBag()
  
  init(viewModel: PopularMovieListViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    configureDataSource()
    
    Task {
      try await viewModel.getPopularMovies()
    }
    
    observeMovies()
  }
  
}
