//
//  MovieRepository.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

protocol MovieRepository {
  func getTopRatedMovies() async throws -> Observable<[Movie]>
  func getPopularMovies() async throws -> Observable<[Movie]>
  func getUpcomingMovies() async throws -> Observable<[Movie]>
}
