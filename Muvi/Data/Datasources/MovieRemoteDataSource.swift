//
//  MovieRemoteDataSource.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

protocol MovieRemoteDataSource {
    func getTopRatedMovies() async throws ->  Observable<[Movie]>
    func getPopularMovies() async throws ->  Observable<[Movie]>
    func getUpcomingMovies() async throws ->  Observable<[Movie]>
}

enum MovieApiError: Error {
    case urlError
    case invalidResponse
    case invalidData
}

struct MovieRemoteDataSourceImpl: MovieRemoteDataSource {
    private let baseUrl = "https://api.themoviedb.org/3/movie"
    private let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTg3MDNmMDVkZWIzOGQwY2QwYzI0ZWM4YTViYTQwYyIsIm5iZiI6MTcyODYzODM5Ny42MzM4NDgsInN1YiI6IjY1ZTQxYWIzMmFjNDk5MDE4NmVmOTc4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.03tux074rl6CtX40Y7EBy9APcJ92Z99JIfNaOEl-stQ"
    
    func getTopRatedMovies() async throws -> Observable<[Movie]> {
        let endpoint = "\(baseUrl)/top_rated?language=en-US&page=1"
        
        guard let url = URL(string: endpoint) else {
            throw MovieApiError.urlError
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(MovieResult.self, from: data)
            let items = response.results ?? []
            
            return Observable.from([items])
        } catch {
            print(error.localizedDescription)
            throw MovieApiError.invalidData
        }
    }
    
    func getPopularMovies() async throws -> Observable<[Movie]> {
        let endpoint = "\(baseUrl)/popular?language=en-US&page=1"
        
        guard let url = URL(string: endpoint) else {
            throw MovieApiError.urlError
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(MovieResult.self, from: data)
            let items = response.results ?? []
            
            return Observable.from([items])
        } catch {
            print(error.localizedDescription)
            throw MovieApiError.invalidData
        }
    }
    
    func getUpcomingMovies() async throws -> Observable<[Movie]> {
        let endpoint = "\(baseUrl)/upcoming?language=en-US&page=1"
        
        guard let url = URL(string: endpoint) else {
            throw MovieApiError.urlError
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(MovieResult.self, from: data)
            let items = response.results ?? []
            
            return Observable.from([items])
        } catch {
            print(error.localizedDescription)
            throw MovieApiError.invalidData
        }
    }
}
