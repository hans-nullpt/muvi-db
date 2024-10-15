//
//  GetMovieList.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct GetTopRatedMoviesUsecase {
  var repository: MovieRepository
  
  func execute() async throws -> Observable<[Movie]> {
    try await repository.getTopRatedMovies()
  }
}
