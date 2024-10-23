//
//  MovieDetailViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 17/10/24.
//

import UIKit
import RxSwift

enum MovieDetailSection: CaseIterable, Hashable {
  case detail
  case castMember
}

class MovieDetailViewController: UIViewController {
  var movie: Movie?
  
  typealias MovieDataSource = UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetail>
  
  var collectionView: UICollectionView!
  let indicator = UIActivityIndicatorView()
  
  internal var datasource: MovieDataSource!
  let viewModel: MovieDetailViewModel
  let disposeBag = DisposeBag()
  
  init(viewModel: MovieDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    configureCollectionView()
    configureDataSource()
    configureIndicatorView()
    
    Task {
      if let id = movie?.id {
        try await viewModel.getMovieDetail(by: id)
      }
    }
    
    observeData()
  }
  
  internal func observeData() {
    viewModel.movieDetail.subscribe { [weak self] state in
      guard let self else { return }
      
      DispatchQueue.main.async {
        self.updateViewState(for: state)
      }
    }.disposed(by: disposeBag)
  }
  
  internal func updateViewState(for state: ViewState<MovieDetail>) {
    if case .success(let data) = state {
      updateCollectionViewData(with: data, for: .detail)
      indicator.stopAnimating()
    }
    
    if case .loading = state {
      indicator.startAnimating()
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
  
  @objc internal func addToFavorite(_ sender: UIButton) {
    guard let movie else { return }
    
    print("Add To Favorite")
    
    viewModel.addToFavorite(movie: movie)
  }
}
