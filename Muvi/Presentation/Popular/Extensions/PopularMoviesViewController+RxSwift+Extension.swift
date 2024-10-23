//
//  PopularMoviesViewController+RxSwift+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 15/10/24.
//

import Foundation
import RxSwift

extension PopularMoviesViewController {
  internal func observeMovies() {
    viewModel.movieList.subscribe(
      onNext: { [weak self] state in
        guard let self else { return }
        
        DispatchQueue.main.async {
          self.updateViewState(for: state)
        }
      }
    ).disposed(by: disposeBag)
  }
  
  internal func updateViewState(for state: ViewState<[Movie]>) {
    if case .success(let items) = state {
      updateCollectionViewData(with: items)
      self.items = items
      indicator.stopAnimating()
    }
    
    if case .loading = state {
      indicator.startAnimating()
    }
  }
}
