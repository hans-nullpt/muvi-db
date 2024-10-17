//
//  HomeViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import UIKit
import RxSwift

enum MovieSection: CaseIterable, Hashable {
  case topRated
  case popular
  case upcoming
  
  var title: String {
    switch self {
      
    case .topRated:
      ""
    case .popular:
      "Popular"
    case .upcoming:
      "Coming Soon"
    }
  }
}

class HomeViewController: UIViewController {
  typealias MovieDataSource = UICollectionViewDiffableDataSource<MovieSection, Movie>
  
  internal let viewModel: MovieListViewModel
  internal let disposeBag = DisposeBag()
  
  internal var collectionView: UICollectionView!
  internal lazy var titleLabel: UILabel = {
    let label = UILabel()
    
    let muviLabelAttr: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 32, weight: .bold)
    ]
    
    let dbLabelAttr = [
      .font: UIFont.systemFont(ofSize: 32, weight: .bold),
      NSAttributedString.Key.foregroundColor: UIColor.systemYellow
    ]
    
    let muviLabelAttrString = NSMutableAttributedString(string: "Muvi", attributes: muviLabelAttr)
    
    let dbLabelAttrString  = NSAttributedString(string: "DB", attributes: dbLabelAttr)
    
    muviLabelAttrString.append(dbLabelAttrString)
    
    label.attributedText = muviLabelAttrString
    
    return label
  }()
  
  internal var datasource: MovieDataSource!
  
  init(viewModel: MovieListViewModel) {
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
      try await viewModel.getTopRatedMovies()
      try await viewModel.getPopularMovies()
      try await viewModel.getUpcomingMovies()
    }
    
    observeTopRatedMovies()
    observePopularMovies()
    observeUpcomingMovies()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let title = UIBarButtonItem()
    title.customView = titleLabel
    navigationItem.leftBarButtonItem = title
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    collectionView.frame = view.bounds
  }
  
}

#Preview(traits: .defaultLayout, body: {
  let datasource = MovieRemoteDataSourceImpl()
  
  let repository = MovieRepositoryImpl(remoteDataSource: datasource)
  
  let topRatedMoviesUsecase = GetTopRatedMoviesUsecase(repository: repository)
  let popularMoviesUsecase = GetPopularMoviesUsecase(repository: repository)
  let upcomingMoviesUsecase = GetUpcomingMoviesUsecase(repository: repository)
  
  let viewModel = MovieListViewModel(
    topRatedMoviesUsecase: topRatedMoviesUsecase,
    popularMoviesUsecase: popularMoviesUsecase,
    upcomingMoviesUsecase: upcomingMoviesUsecase
  )
  
  HomeViewController(viewModel: viewModel)
})
