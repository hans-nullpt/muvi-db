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
  func searchMovies(_ keyword: String) async throws -> Observable<[Movie]>
  func getMovie(by id: Int) async throws -> Observable<MovieDetail>
  func getFavoriteMovies() throws -> Observable<[Movie]>
  func addToFavorite(movie: Movie) throws -> Observable<Bool>
}
