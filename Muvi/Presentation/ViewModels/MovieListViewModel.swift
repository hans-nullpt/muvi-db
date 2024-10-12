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
    let state: BehaviorRelay<ViewState> = BehaviorRelay(value: .initial)
    
    private let disposeBag = DisposeBag()
    private let usecase: GetTopRatedMoviesUsecase
    
    init(usecase: GetTopRatedMoviesUsecase) {
        self.usecase = usecase
    }
    
    func getMovieList() async throws {
        state.accept(.loading)
        
        do {
            let items = try await usecase.execute()
            
            items.subscribe(
                onNext: { [weak self] items in
                    print("On Next")
                    self?.state.accept(.success(items: items))
                },
                onError: { [weak self] error in
                    guard let self else { return }
                    
                    self.state.accept(.error(message: error.localizedDescription))
                }
            ).disposed(by: disposeBag)
        } catch {
            state.accept(.error(message: error.localizedDescription))
        }
        
        
    }
}
