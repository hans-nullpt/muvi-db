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
  var id: Int?
  
  typealias MovieDataSource = UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetail>
  
  var collectionView: UICollectionView!
  
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
    
    Task {
      if let id {
        try await viewModel.getMovieDetail(by: id)
      }
    }
    
    observeData()
  }
  
  internal func observeData() {
    viewModel.movieDetail.subscribe { [weak self] state in
      guard let self else { return }
      
      updateViewState(for: state)
    }.disposed(by: disposeBag)
  }
  
  internal func updateViewState(for state: ViewState<MovieDetail>) {
    if case .success(let data) = state {
      updateCollectionViewData(with: data, for: .detail)
    }
  }
}
