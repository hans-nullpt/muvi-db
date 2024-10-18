//
//  HomeViewController+RxSwift+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import Foundation

extension HomeViewController {
  
  internal func observeTopRatedMovies() {
    viewModel.topRatedMovies.subscribe(
      onNext: { [weak self] state in
        guard let self else { return }
        
        DispatchQueue.main.async {
          self.updateTopRatedMoviesState(for: state)
        }
      }
    ).disposed(by: disposeBag)
  }
  
  internal func observePopularMovies() {
    viewModel.popularMovies.subscribe(
      onNext: { [weak self] state in
        guard let self else { return }
        
        DispatchQueue.main.async {
          self.updatePopularMoviesState(for: state)
        }
      }
    ).disposed(by: disposeBag)
  }
  
  internal func observeUpcomingMovies() {
    viewModel.upcomingMovies.subscribe(
      onNext: { [weak self] state in
        guard let self else { return }
        
        DispatchQueue.main.async {
          self.updateUpcomingMoviesState(for: state)
        }
      }
    ).disposed(by: disposeBag)
  }
  
  internal func updateTopRatedMoviesState(for state: ViewState<[Movie]>) {
    if case .success(let items) = state {
      let minCount = min(5, items.count - 1)
      let movies = Array(items[0...minCount])
      
      topRatedMovies = movies
      updateCollectionViewData(with: movies, for: .topRated)
    }
  }
  
  internal func updatePopularMoviesState(for state: ViewState<[Movie]>) {
    if case .success(let items) = state {
      popularMovies = items
      updateCollectionViewData(with: items, for: .popular)
    }
  }
  
  internal func updateUpcomingMoviesState(for state: ViewState<[Movie]>) {
    if case .success(let items) = state {
      upcomingMovies = items
      updateCollectionViewData(with: items, for: .upcoming)
    }
  }
}
