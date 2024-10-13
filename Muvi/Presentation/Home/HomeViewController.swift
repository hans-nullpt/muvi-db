//
//  HomeViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

import UIKit
import RxSwift

enum MovieSection: CaseIterable, Hashable {
    case topRated
    case popular
    case upcoming
    
    var title: String {
        switch self {
            
        case .topRated:
            ""
        case .popular:
            "Popular"
        case .upcoming:
            "Coming Soon"
        }
    }
}

class HomeViewController: UIViewController {
    typealias MovieDataSource = UICollectionViewDiffableDataSource<MovieSection, Movie>
    
    internal let viewModel: MovieListViewModel
    internal let disposeBag = DisposeBag()
    
    internal let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { index, _ in
            HomeViewController.createCompositionalLayout(for: index)
        }
    )
    
    internal var datasource: MovieDataSource!
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
        
        Task {
            try await viewModel.getTopRatedMovies()
            try await viewModel.getPopularMovies()
            try await viewModel.getUpcomingMovies()
        }
        
        
        observeTopRatedMovies()
        observePopularMovies()
        observeUpcomingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let label = UILabel()
        
        let muviLabelAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 32, weight: .bold)
        ]
        
        let dbLabelAttr = [
            .font: UIFont.systemFont(ofSize: 32, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.systemYellow
        ]
        
        let muviLabelAttrString = NSMutableAttributedString(string: "Muvi", attributes: muviLabelAttr)
        
        let dbLabelAttrString  = NSAttributedString(string: "DB", attributes: dbLabelAttr)
        
        muviLabelAttrString.append(dbLabelAttrString)
        
        label.attributedText = muviLabelAttrString
        
        let title = UIBarButtonItem()
        title.customView = label
        navigationItem.leftBarButtonItem = title
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }

    internal func updateTopRatedMoviesState(for state: ViewState) {
        if case .success(let items) = state {
            updateCollectionViewData(with: items, for: .topRated)
        }
    }
    
    internal func updatePopularMoviesState(for state: ViewState) {
        if case .success(let items) = state {
            updateCollectionViewData(with: items, for: .popular)
        }
    }
    
    internal func updateUpcomingMoviesState(for state: ViewState) {
        if case .success(let items) = state {
            updateCollectionViewData(with: items, for: .upcoming)
        }
    }
    
    static func createCompositionalLayout(for section: Int) -> NSCollectionLayoutSection {
        
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(20)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        switch section {
        case 0:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
            
            // Group
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(259)
                ),
                subitem: item,
                count: 1
            )
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 0)
            
            return section
            
        default:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ))
            
            // Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ),
                subitem: item,
                count: 1
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.85),
                    heightDimension: .absolute(157)
                ),
                subitem: verticalGroup,
                count: 3
            )
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 32, trailing: 20)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 8
            section.boundarySupplementaryItems = supplementaryViews
            
            return section
        }
    }

}

#Preview(traits: .defaultLayout, body: {
    let datasource = MovieRemoteDataSourceImpl()
    
    let repository = MovieRepositoryImpl(remoteDataSource: datasource)
    
    let topRatedMoviesUsecase = GetTopRatedMoviesUsecase(repository: repository)
    let popularMoviesUsecase = GetPopularMoviesUsecase(repository: repository)
    let upcomingMoviesUsecase = GetUpcomingMoviesUsecase(repository: repository)
    
    let viewModel = MovieListViewModel(
        topRatedMoviesUsecase: topRatedMoviesUsecase,
        popularMoviesUsecase: popularMoviesUsecase,
        upcomingMoviesUsecase: upcomingMoviesUsecase
    )
    
    HomeViewController(viewModel: viewModel)
})
