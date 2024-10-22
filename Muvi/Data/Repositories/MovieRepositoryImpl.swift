//
//  MovieRepositoryImpl.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct MovieRepositoryImpl: MovieRepository {
  
  fileprivate let remoteDataSource: MovieRemoteDataSource
  fileprivate let localDataSource: MovieLocalDataSource
  
  init(remoteDataSource: MovieRemoteDataSource, localDataSource: MovieLocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }
  
  func getTopRatedMovies() async throws -> Observable<[Movie]> {
    do {
      return try await remoteDataSource.getTopRatedMovies()
    } catch {
      throw error
    }
  }
  
  func getPopularMovies() async throws -> Observable<[Movie]> {
    do {
      return try await remoteDataSource.getPopularMovies()
    } catch {
      throw error
    }
  }
  
  func getUpcomingMovies() async throws -> Observable<[Movie]> {
    do {
      return try await remoteDataSource.getUpcomingMovies()
    } catch {
      throw error
    }
  }
  
  func searchMovies(_ keyword: String) async throws -> Observable<[Movie]> {
    do {
      return try await remoteDataSource.searchMovies(keyword)
    } catch {
      throw error
    }
  }
  
  func getMovie(by id: Int) async throws -> Observable<MovieDetail> {
    do {
      return try await remoteDataSource.getMovie(by: id)
    } catch {
      throw error
    }
  }
  
  func getFavoriteMovies() throws -> Observable<[Movie]> {
    do {
      return try localDataSource.getFavoriteMovies()
    } catch {
      throw error
    }
  }
  
  func addToFavorite(movie: Movie) throws -> Observable<Bool> {
    do {
      return try localDataSource.addToFavorite(movie: movie)
    } catch {
      throw error
    }
  }
  
}
