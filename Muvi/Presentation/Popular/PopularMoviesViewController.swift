//
//  PopularMoviesViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit
import RxSwift
import RxCocoa

class PopularMoviesViewController: UIViewController {
  typealias MovieDataSource = UICollectionViewDiffableDataSource<Int, Movie>
  
  internal var collectionView: UICollectionView!
  internal lazy var searchField: UITextField = {
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    field.placeholder = "Search Movie"
    field.rightView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    field.tintColor = .systemYellow
    field.rightViewMode = .always
    
    return field
  }()
  
  let indicator = UIActivityIndicatorView()
  
  internal var datasource: MovieDataSource!
  
  internal let viewModel: PopularMovieListViewModel
  internal let disposeBag = DisposeBag()
  internal var items: [Movie] = []
  internal var filteredItems: [Movie]?
  
  //MARK: configure tab bar manually (opaque)
  
  init(viewModel: PopularMovieListViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSearchField()
    configureCollectionView()
    configureDataSource()
    configureIndicatorView()
    
    Task {
      try await viewModel.getPopularMovies()
    }
    
    observeMovies()
  }
  
  internal func configureSearchField() {
    view.addSubview(searchField)
    
    searchField.delegate = self
    
    searchField.rx.text.orEmpty
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe { [weak self] value in
        guard let self else { return }
        
        if case .next(let value) = value {
          Task {
            if value.isEmpty {
              try await self.viewModel.getPopularMovies()
            } else {
              try await self.viewModel.searchMovie(value)
            }
          }
        }
      }
      .disposed(by: disposeBag)
    
    searchField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
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
