//
//  MuviTabBarViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

class MuviTabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = [ homeViewController, populerViewController, favoriteViewController ]
    tabBar.tintColor = .systemYellow
  }
  
  lazy var homeViewController: UINavigationController = {
    let remoteDataSource = MovieRemoteDataSourceImpl()
    let localDataSource = MovieLocalDataSourceImpl(database: CoreDataManager.shared)
    
    let repository = MovieRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource
    )
    
    let topRatedMoviesUsecase = GetTopRatedMoviesUsecase(repository: repository)
    let popularMoviesUsecase = GetPopularMoviesUsecase(repository: repository)
    let upcomingMoviesUsecase = GetUpcomingMoviesUsecase(repository: repository)
    
    let viewModel = MovieListViewModel(
      topRatedMoviesUsecase: topRatedMoviesUsecase,
      popularMoviesUsecase: popularMoviesUsecase,
      upcomingMoviesUsecase: upcomingMoviesUsecase
    )
    
    let viewController = HomeViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
    
    return UINavigationController(rootViewController: viewController)
  }()
  
  lazy var populerViewController: UINavigationController = {
    let remoteDataSource = MovieRemoteDataSourceImpl()
    let localDataSource = MovieLocalDataSourceImpl(database: CoreDataManager.shared)
    
    let repository = MovieRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource
    )
    
    let popularMoviesUsecase = GetPopularMoviesUsecase(repository: repository)
    let searchMoviesUsecase = SearchMoviesUsecase(repository: repository)
    
    let viewModel = PopularMovieListViewModel(
      popularMoviesUsecase: popularMoviesUsecase,
      searchMoviesUsecase: searchMoviesUsecase
    )
    
    let viewController = PopularMoviesViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "rosette"), tag: 1)
    
    return UINavigationController(rootViewController: viewController)
  }()
  
  lazy var favoriteViewController: UINavigationController = {
    let viewController = FavoriteViewController()
    viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 2)
    
    return UINavigationController(rootViewController: viewController)
  }()
  
}
