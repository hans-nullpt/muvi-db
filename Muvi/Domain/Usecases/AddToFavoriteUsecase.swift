//
//  AddToFavoriteUsecase.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 22/10/24.
//

import Foundation
import RxSwift

struct AddToFavoriteUsecase {
  var repository: MovieRepository
  
  func execute(movie: Movie) throws -> Observable<Bool> {
    try repository.addToFavorite(movie: movie)
  }
}
