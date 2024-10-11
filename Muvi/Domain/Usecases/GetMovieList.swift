//
//  GetMovieList.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift

struct GetMovieList {
    var repository: MovieRepository
    
    func callAsFunction() -> Observable<[Movie]> {
        repository.getMovieList()
    }
}
