//
//  MovieRemoteDataSource.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Alamofire
import Foundation
import RxSwift

protocol MovieRemoteDataSource {
  func getTopRatedMovies() async throws -> Observable<[Movie]>
  func getPopularMovies() async throws -> Observable<[Movie]>
  func getUpcomingMovies() async throws -> Observable<[Movie]>
  func searchMovies(_ keyword: String) async throws -> Observable<[Movie]>
}

enum MovieApiError: Error {
  case urlError
  case invalidResponse
  case invalidData
}

struct MovieRemoteDataSourceImpl: MovieRemoteDataSource {
  private let baseUrl = "https://api.themoviedb.org/3"
  private let accessToken =
  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTg3MDNmMDVkZWIzOGQwY2QwYzI0ZWM4YTViYTQwYyIsIm5iZiI6MTcyODYzODM5Ny42MzM4NDgsInN1YiI6IjY1ZTQxYWIzMmFjNDk5MDE4NmVmOTc4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.03tux074rl6CtX40Y7EBy9APcJ92Z99JIfNaOEl-stQ"
  
  func getTopRatedMovies() async throws -> Observable<[Movie]> {
    let endpoint = "\(baseUrl)/movie/top_rated?language=en-US&page=1"
    
    let headers: HTTPHeaders = [
      .authorization(bearerToken: accessToken)
    ]
    
    do {
      
      let response = await AF.request(endpoint, method: .get, headers: headers)
        .serializingDecodable(MovieResult.self)
        .response
      
      let items = (try response.result.get()).results
      
      return Observable.from([items ?? []])
    } catch {
      print(error.localizedDescription)
      throw MovieApiError.invalidData
    }
  }
  
  func getPopularMovies() async throws -> Observable<[Movie]> {
    let endpoint = "\(baseUrl)/movie/popular?language=en-US&page=1"
    
    let headers: HTTPHeaders = [
      .authorization(bearerToken: accessToken)
    ]
    
    do {
      
      let response = await AF.request(endpoint, method: .get, headers: headers)
        .serializingDecodable(MovieResult.self)
        .response
      
      let items = (try response.result.get()).results
      
      return Observable.from([items ?? []])
    } catch {
      print(error.localizedDescription)
      throw MovieApiError.invalidData
    }
  }
  
  func getUpcomingMovies() async throws -> Observable<[Movie]> {
    let endpoint = "\(baseUrl)/movie/upcoming?language=en-US&page=1"
    
    let headers: HTTPHeaders = [
      .authorization(bearerToken: accessToken)
    ]
    
    do {
      
      let response = await AF.request(endpoint, method: .get, headers: headers)
        .serializingDecodable(MovieResult.self)
        .response
      
      let items = (try response.result.get()).results
      
      return Observable.from([items ?? []])
    } catch {
      print(error.localizedDescription)
      throw MovieApiError.invalidData
    }
  }
  
  func searchMovies(_ keyword: String) async throws -> Observable<[Movie]> {
    let endpoint = "\(baseUrl)/search/movie?query=\(keyword)"
    print(endpoint)
    let headers: HTTPHeaders = [
      .authorization(bearerToken: accessToken)
    ]
    
    do {
      
      let response = await AF.request(endpoint, method: .get, headers: headers)
        .serializingDecodable(MovieResult.self)
        .response
      
      let items = (try response.result.get()).results
      
      return Observable.from([items ?? []])
    } catch {
      print(error.localizedDescription)
      throw MovieApiError.invalidData
    }
  }
  
}
