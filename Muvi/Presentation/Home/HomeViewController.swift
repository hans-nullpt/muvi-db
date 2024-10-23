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
  let indicator = UIActivityIndicatorView()
  
  internal var datasource: MovieDataSource!
  internal var topRatedMovies: [Movie] = []
  internal var popularMovies: [Movie] = []
  internal var upcomingMovies: [Movie] = []
  
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
    configureIndicatorView()
    
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
  
  internal func configureIndicatorView() {
    indicator.style = .large
    indicator.backgroundColor = .tertiarySystemBackground
    indicator.layer.cornerRadius = 16
    
    view.addSubview(indicator)
    
    indicator.snp.makeConstraints { make in
      make.height.width.equalTo(200)
      make.center.equalToSuperview()
    }
  }
  
}
