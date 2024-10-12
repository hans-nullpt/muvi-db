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
        print("GetMovieListUsecase")
        
        do {
            let items = try await repository.getTopRatedMovies()
            return items
        } catch {
            throw error
        }
    }
}
