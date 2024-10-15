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
    
    let viewController = HomeViewController(viewModel: viewModel)
    viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
    
    return UINavigationController(rootViewController: viewController)
  }()
  
  lazy var populerViewController: UINavigationController = {
    let datasource = MovieRemoteDataSourceImpl()
    
    let repository = MovieRepositoryImpl(remoteDataSource: datasource)
    
    let popularMoviesUsecase = GetPopularMoviesUsecase(repository: repository)
    
    let viewModel = PopularMovieListViewModel(
      popularMoviesUsecase: popularMoviesUsecase
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
