//
//  HomeViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    internal let viewModel: MovieListViewModel
    internal let disposeBag = DisposeBag()
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            try await viewModel.getTopRatedMovies()
            try await viewModel.getPopularMovies()
            try await viewModel.getUpcomingMovies()
        }
        
        observeTopRatedMovies()
        observePopularMovies()
        observeUpcomingMovies()
    }
    

    internal func updateTopRatedMoviesState(for state: ViewState) {
        
    }
    
    internal func updatePopularMoviesState(for state: ViewState) {
        
    }
    
    internal func updateUpcomingMoviesState(for state: ViewState) {
        
    }

}
