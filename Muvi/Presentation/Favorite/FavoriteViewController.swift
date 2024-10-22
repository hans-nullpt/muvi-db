//
//  FavoriteViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit
import SnapKit
import RxSwift

class FavoriteViewController: UIViewController {
  typealias MovieDataSource = UITableViewDiffableDataSource<Int, Movie>
  
  internal var tableView: UITableView!
  internal lazy var searchField: UITextField = {
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    field.placeholder = "Search Movie"
    field.rightView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    field.tintColor = .systemYellow
    field.rightViewMode = .always
    
    return field
  }()
  
  let disposeBag = DisposeBag()
  
  var datasource: MovieDataSource!
  
  let viewModel: FavoriteMovieViewModel
  
  var items: [Movie] = []
  
  init(viewModel: FavoriteMovieViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    configureSearchField()
    configureTableView()
    configureDatasource()
    
    Task {
      try await viewModel.getFavoriteMovies()
    }
    
    observeMovies()
  }
  
  internal func configureTableView() {
    tableView = UITableView(frame: view.bounds)
    tableView.rowHeight = 106
    tableView.separatorStyle = .none
    
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(searchField.snp.bottom).offset(24)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    tableView.register(FavoriteMovieCell.nib(), forCellReuseIdentifier: FavoriteMovieCell.reusableId)
    tableView.delegate = self
    
  }
  
  internal func configureDatasource() {
    datasource = MovieDataSource(tableView: tableView) { tableView, indexPath, movie in
      let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reusableId, for: indexPath) as? FavoriteMovieCell
      
      guard let cell else { return nil }
      
      cell.updateData(with: movie)
      
      return cell
    }
  }
  
  internal func updateTableViewData(with movies: [Movie]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
    snapshot.appendSections([0])
    snapshot.appendItems(movies)
    
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.datasource.apply(snapshot)
    }
  }
  
  internal func configureSearchField() {
    view.addSubview(searchField)
    
    searchField.delegate = self
    
    searchField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
  }
  
  internal func observeMovies() {
    viewModel.movies.subscribe(
      onNext: { [weak self] state in
        guard let self else { return }
        
        DispatchQueue.main.async {
          self.updateFavoriteMoviesState(for: state)
        }
      }
    ).disposed(by: disposeBag)
  }
  
  internal func updateFavoriteMoviesState(for state: ViewState<[Movie]>) {
    if case .success(let items) = state {
      updateTableViewData(with: items)
      self.items = items
    }
  }
  
}

extension FavoriteViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.item]
    
    let remoteDataSource = MovieRemoteDataSourceImpl()
    let localDataSource = MovieLocalDataSourceImpl(database: CoreDataManager.shared)
    
    let repository = MovieRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource
    )
    
    let detailUsecase = GetMovieDetail(repository: repository)
    let addToFavoriteUsecase = AddToFavoriteUsecase(repository: repository)
    
    let vm = MovieDetailViewModel(movieDetailUsecase: detailUsecase, addToFavoriteUsecase: addToFavoriteUsecase)
    let vc = MovieDetailViewController(viewModel: vm)
    vc.movie = item
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension FavoriteViewController: UISearchTextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
//    if let keyword = textField.text, !keyword.isEmpty {
//      Task {
//        try await viewModel.searchMovie(keyword)
//      }
//    } else {
//      Task {
//        try await viewModel.getPopularMovies()
//      }
//    }
    
    return true
  }
}
