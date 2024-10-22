//
//  MovieDetailViewModel.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 18/10/24.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailViewModel {
  let movieDetail: BehaviorRelay<ViewState<MovieDetail>> = BehaviorRelay(value: .initial)
  
  private let disposeBag = DisposeBag()
  private let movieDetailUsecase: GetMovieDetail
  private let addToFavoriteUsecase: AddToFavoriteUsecase
  
  init(movieDetailUsecase: GetMovieDetail, addToFavoriteUsecase: AddToFavoriteUsecase) {
    self.movieDetailUsecase = movieDetailUsecase
    self.addToFavoriteUsecase = addToFavoriteUsecase
  }
  
  func getMovieDetail(by id: Int) async throws {
    movieDetail.accept(.loading)
    
    do {
      let items = try await movieDetailUsecase.execute(id: id)
      
      items.subscribe(
        onNext: { [weak self] item in
          guard let self else { return }
          
          self.movieDetail.accept(.success(item))
        },
        onError: { [weak self] error in
          guard let self else { return }
          
          self.movieDetail.accept(.error(message: error.localizedDescription))
        }
      ).disposed(by: disposeBag)
    } catch {
      movieDetail.accept(.error(message: error.localizedDescription))
    }
    
  }
  
  func addToFavorite(movie: Movie) {
    do {
      let items = try addToFavoriteUsecase.execute(movie: movie)
      
      items.subscribe(
        onNext: { [weak self] item in
          guard let self else { return }
          
//          self.movieDetail.accept(.success(item))
        },
        onError: { [weak self] error in
          guard let self else { return }
          
//          self.movieDetail.accept(.error(message: error.localizedDescription))
        }
      ).disposed(by: disposeBag)
    } catch {
      print(error.localizedDescription)
    }
  }
}
