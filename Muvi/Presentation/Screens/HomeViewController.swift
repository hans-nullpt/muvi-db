//
//  HomeViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    private let viewModel: MovieListViewModel
    private let disposeBag = DisposeBag()
    
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
            try await viewModel.getPopularMovies()
        }
        
        viewModel.popularMovies.subscribe(
            onNext: { [weak self] state in
                switch state {
                case .initial:
                    print("Initial")
                case .loading:
                    print("Loading")
                case .success(items: let items):
                    print("Success: \(items.count)")
                    
                    for item in items {
                        print(item.title)
                    }
                case .error(message: let message):
                    print("Error: \(message)")
                }
            }
        ).disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
