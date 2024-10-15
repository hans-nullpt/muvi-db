//
//  MovieListViewModel.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift
import RxRelay

class PopularMovieListViewModel {
  let movieList: BehaviorRelay<ViewState> = BehaviorRelay(value: .initial)
  
  private let disposeBag = DisposeBag()
  private let popularMoviesUsecase: GetPopularMoviesUsecase
  
  init(
    popularMoviesUsecase: GetPopularMoviesUsecase
  ) {
    self.popularMoviesUsecase = popularMoviesUsecase
  }
  
  func getPopularMovies() async throws {
    movieList.accept(.loading)
    
    do {
      let items = try await popularMoviesUsecase.execute()
      
      items.subscribe(
        onNext: { [weak self] items in
          guard let self else { return }
          
          self.movieList.accept(.success(items: items))
        },
        onError: { [weak self] error in
          guard let self else { return }
          
          self.movieList.accept(.error(message: error.localizedDescription))
        }
      ).disposed(by: disposeBag)
    } catch {
      movieList.accept(.error(message: error.localizedDescription))
    }
    
  }
  
}
