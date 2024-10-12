//
//  MovieListViewModel.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import Foundation
import RxSwift
import RxRelay

enum ViewState { case initial, loading, success(items: [Movie]), error(message: String) }

class MovieListViewModel {
    let topRatedMovies: BehaviorRelay<ViewState> = BehaviorRelay(value: .initial)
    let popularMovies: BehaviorRelay<ViewState> = BehaviorRelay(value: .initial)
    
    private let disposeBag = DisposeBag()
    private let usecase: GetTopRatedMoviesUsecase
    
    init(usecase: GetTopRatedMoviesUsecase) {
        self.usecase = usecase
    }
    
    func getTopRatedMovies() async throws {
        topRatedMovies.accept(.loading)
        
        do {
            let items = try await usecase.execute()
            
            items.subscribe(
                onNext: { [weak self] items in
                    print("On Next")
                    self?.topRatedMovies.accept(.success(items: items))
                },
                onError: { [weak self] error in
                    guard let self else { return }
                    
                    self.topRatedMovies.accept(.error(message: error.localizedDescription))
                }
            ).disposed(by: disposeBag)
        } catch {
            topRatedMovies.accept(.error(message: error.localizedDescription))
        }
        
    }
    
    func getPopularMovies() async throws {
        popularMovies.accept(.loading)
        
        do {
            let items = try await usecase.execute()
            
            items.subscribe(
                onNext: { [weak self] items in
                    print("On Next")
                    self?.popularMovies.accept(.success(items: items))
                },
                onError: { [weak self] error in
                    guard let self else { return }
                    
                    self.popularMovies.accept(.error(message: error.localizedDescription))
                }
            ).disposed(by: disposeBag)
        } catch {
            popularMovies.accept(.error(message: error.localizedDescription))
        }
        
    }
}
