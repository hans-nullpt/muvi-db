//
//  GetMovieDetail.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct GetMovieDetail {
  var repository: MovieRepository
  
  func execute(id: Int) async throws -> Observable<MovieDetail> {
    try await repository.getMovie(by: id)
  }
}
