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
  internal lazy var searchField: UITextField = {
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    field.placeholder = "Search Movie"
    field.rightView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    field.tintColor = .systemYellow
    field.rightViewMode = .always
    
    return field
  }()
  
  internal var datasource: MovieDataSource!
  
  internal let viewModel: PopularMovieListViewModel
  internal let disposeBag = DisposeBag()
  internal var items: [Movie] = []
  
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
    
    Task {
      try await viewModel.getPopularMovies()
    }
    
    observeMovies()
  }
  
  internal func configureSearchField() {
    view.addSubview(searchField)
    
    searchField.delegate = self
    
    searchField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
  }
  
}
