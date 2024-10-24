//
//  RemoveFromFavoriteUsecase.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 22/10/24.
//

import Foundation
import RxSwift

struct RemoveFromFavoriteUsecase {
  var repository: MovieRepository
  
  func execute(movie: Movie) throws -> Observable<Bool> {
    try repository.removeFromFavorite(movie: movie)
  }
}
