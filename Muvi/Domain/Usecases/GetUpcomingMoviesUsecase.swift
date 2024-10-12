//
//  GetUpcomingMoviesUsecase.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct GetUpcomingMoviesUsecase {
    var repository: MovieRepository
    
    func execute() async throws -> Observable<[Movie]> {
        print("GetUpcomingMoviesUsecase")
        
        do {
            let items = try await repository.getUpcomingMovies()
            return items
        } catch {
            throw error
        }
    }
}
