//
//  FavoriteMovieViewModel.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 22/10/24.
//

import Foundation
import RxRelay
import RxSwift

class FavoriteMovieViewModel {
  let movies: BehaviorRelay<ViewState<[Movie]>> = BehaviorRelay(value: .initial)
  
  private let disposeBag = DisposeBag()
  private let favoriteMoviesUsecase: GetFavoriteMoviesUsecase
  
  init(favoriteMoviesUsecase: GetFavoriteMoviesUsecase) {
    self.favoriteMoviesUsecase = favoriteMoviesUsecase
  }
  
  func getFavoriteMovies() async throws {
    movies.accept(.loading)
    
    do {
      let items = try await favoriteMoviesUsecase.execute()
      
      items.subscribe(
        onNext: { [weak self] items in
          guard let self else { return }
          
          self.movies.accept(.success(items))
        },
        onError: { [weak self] error in
          guard let self else { return }
          
          self.movies.accept(.error(message: error.localizedDescription))
        }
      ).disposed(by: disposeBag)
    } catch {
      movies.accept(.error(message: error.localizedDescription))
    }
    
  }
}
