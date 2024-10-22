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
  func getFavoriteMovies() async throws -> Observable<[Movie]>
}

struct MovieLocalDataSourceImpl: MovieLocalDataSource {
  
  let database: CoreDataManager
  var context: NSManagedObjectContext?
  
  init(database: CoreDataManager) {
    self.database = database
    self.context = database.container.viewContext
  }
  
  func getFavoriteMovies() async throws -> Observable<[Movie]> {
    
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
      throw MovieApiError.invalidData
    }
  }
  
}
