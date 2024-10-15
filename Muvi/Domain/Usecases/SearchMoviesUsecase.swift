//
//  SearchMoviesUsecase.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct SearchMoviesUsecase {
  var repository: MovieRepository
  
  func execute(_ keyword: String) async throws -> Observable<[Movie]> {
    try await repository.searchMovies(keyword)
  }
}
