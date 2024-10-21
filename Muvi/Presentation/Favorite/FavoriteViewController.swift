//
//  FavoriteViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
  typealias MovieDataSource = UITableViewDiffableDataSource<Int, Movie>
  
  var tableView: UITableView!
  
  var datasource: MovieDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    configureTableView()
    configureDatasource()
  }
  
  internal func configureTableView() {
    tableView = UITableView(frame: view.bounds)
    
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    tableView.register(FavoriteMovieCell.nib(), forCellReuseIdentifier: FavoriteMovieCell.reusableId)
    
  }
  
  internal func configureDatasource() {
    datasource = MovieDataSource(tableView: tableView) { tableView, indexPath, movie in
      let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reusableId, for: indexPath) as? FavoriteMovieCell
      
      guard let cell else { return nil }
      
      cell.updateData(with: movie)
      
      return cell
    }
  }
  
  internal func updateTableViewData(with movies: [Movie]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
    snapshot.appendSections([0])
    snapshot.appendItems(movies)
    
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.datasource.apply(snapshot)
    }
  }
  
}
