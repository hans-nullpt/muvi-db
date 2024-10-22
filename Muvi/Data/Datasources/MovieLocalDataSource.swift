//
//  MovieLocalDataSource.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 22/10/24.
//

import Foundation
import RxSwift
import CoreData

protocol MovieLocalDataSource {
  func addToFavorite(movie: Movie) throws -> Observable<Bool>
  func getFavoriteMovies() throws -> Observable<[Movie]>
  func searchMovies(_ keyword: String) throws -> Observable<[Movie]>
}

enum MovieLocalDataError: Error {
  case invalidData
  case failedToStore
}

struct MovieLocalDataSourceImpl: MovieLocalDataSource {
  
  let database: CoreDataManager
  var context: NSManagedObjectContext?
  
  init(database: CoreDataManager) {
    self.database = database
    self.context = database.container.viewContext
  }
  
  func addToFavorite(movie: Movie) throws -> Observable<Bool> {
    guard let context else { return Observable.of(false) }
    
    guard !itemExists(movie.id!) else { return Observable.of(false) }
    
    let data = FavoriteMovieEntity(context: context)
    data.id = Int64(movie.id ?? 0)
    data.adult = movie.adult ?? false
    data.backdropPath = movie.backdropPath
    data.posterPath = movie.posterPath
    data.originalLanguage = movie.originalLanguage
    data.title = movie.title
    data.originalTitle = movie.originalTitle
    data.overview = movie.overview
    data.releaseDate = movie.releaseDate
    data.popularity = movie.popularity ?? 0
    data.voteCount = Int64(movie.voteCount ?? 0)
    data.voteAverage = movie.voteAverage ?? 0
    data.video = movie.video ?? false
    
    do {
      try context.save()
      
      return Observable.of(true)
    } catch {
      throw MovieLocalDataError.failedToStore
    }
  }
  
  func getFavoriteMovies() throws -> Observable<[Movie]> {
    
    var items: [Movie] = []
    
    guard let context else { return Observable.of(items) }
    
    let request = FavoriteMovieEntity.fetchRequest()
    
    do {
      let response = try context.fetch(request)
      let mappedResponse = response.map { data in
        Movie(
          popularity: data.popularity,
          voteCount: Int(data.voteCount),
          posterPath: data.posterPath,
          releaseDate: data.releaseDate,
          overview: data.overview,
          voteAverage: data.voteAverage,
          backdropPath: data.backdropPath,
          id: Int(data.id),
          adult: data.adult,
          video: data.video,
          originalLanguage: data.originalLanguage,
          title: data.title,
          genreIds: [],
          originalTitle: data.originalTitle
        )
      }
      
      items.append(contentsOf: mappedResponse)
      
      return Observable.of(items)
    } catch {
      print(error.localizedDescription)
      throw MovieLocalDataError.invalidData
    }
  }
  
  func searchMovies(_ keyword: String) throws -> Observable<[Movie]> {
    guard let context else { return Observable.of([]) }
    
    do {
      let fetchRequest = FavoriteMovieEntity.fetchRequest()
      let predicate: NSPredicate = NSPredicate(format: "title == %@", keyword)
      fetchRequest.predicate = predicate
      
      let response = try context.fetch(fetchRequest)
      let items = response.map { data in
        Movie(
          popularity: data.popularity,
          voteCount: Int(data.voteCount),
          posterPath: data.posterPath,
          releaseDate: data.releaseDate,
          overview: data.overview,
          voteAverage: data.voteAverage,
          backdropPath: data.backdropPath,
          id: Int(data.id),
          adult: data.adult,
          video: data.video,
          originalLanguage: data.originalLanguage,
          title: data.title,
          genreIds: [],
          originalTitle: data.originalTitle
        )
      }
      
      return Observable.of(items)
    } catch {
      print(error.localizedDescription)
      throw MovieLocalDataError.invalidData
    }
  }
  
  private func itemExists(_ id: Int) -> Bool {
    guard let context else { return false }
    
    do {
      let fetchRequest = FavoriteMovieEntity.fetchRequest()
      let predicate: NSPredicate = NSPredicate(format: "id == %d", Int(id))
      fetchRequest.predicate = predicate
      
      return try context.count(for: fetchRequest) > 0
    } catch {
      print(error.localizedDescription)
      return false
    }
    
  }
  
}
