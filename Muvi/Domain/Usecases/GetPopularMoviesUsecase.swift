//
//  GetPopularMoviesUsecase.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct GetPopularMoviesUsecase {
    var repository: MovieRepository
    
    func execute() async throws -> Observable<[Movie]> {
        print("GetPopularMoviesUsecase")
        
        do {
            let items = try await repository.getPopularMovies()
            return items
        } catch {
            throw error
        }
    }
}