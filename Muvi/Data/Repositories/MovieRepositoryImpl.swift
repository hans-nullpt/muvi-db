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
    
    init(remoteDataSource: MovieRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getMovieList() async throws -> Observable<[Movie]> {
        print("Movie Repo: getMovieList()")
        
        do {
            return try await remoteDataSource.getMovieList()
        } catch {
            throw error
        }
    }
    
    
}
