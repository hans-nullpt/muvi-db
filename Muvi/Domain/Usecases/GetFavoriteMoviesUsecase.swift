//
//  GetFavoriteMoviesUsecase.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 22/10/24.
//

import Foundation
import RxSwift

struct GetFavoriteMoviesUsecase {
  var repository: MovieRepository
  
  func execute() async throws -> Observable<[Movie]> {
    try await repository.getFavoriteMovies()
  }
}
