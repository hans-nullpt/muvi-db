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
  func getFavoriteMovies() -> Observable<Movie>
}

struct MovieLocalDataSourceImpl: MovieLocalDataSource {
  
  let database: CoreDataManager
  var context: NSManagedObjectContext?
  
  init(database: CoreDataManager) {
    self.database = database
    self.context = database.container.viewContext
  }
  
  func getFavoriteMovies() -> Observable<Movie> {
    Observable.from([])
  }
  
}
