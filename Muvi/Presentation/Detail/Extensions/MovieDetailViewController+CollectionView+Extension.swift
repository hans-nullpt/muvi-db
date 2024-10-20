//
//  MovieDetailViewController+CollectionView+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 18/10/24.
//

import Foundation
import UIKit

extension MovieDetailViewController {
  internal func configureCollectionView() {
    collectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: UICollectionViewCompositionalLayout { [weak self] index, _ in
        index == 0 ? self?.createMovieDetailLayout() : self?.createMovieCastMemberLayout()
      }
    )
    
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    collectionView.register(
      MovieDetailBackgroundCell.nib(),
      forCellWithReuseIdentifier: MovieDetailBackgroundCell.reusableId
    )
  }
  
  internal func createMovieDetailLayout() -> NSCollectionLayoutSection {
    // Item
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    ))
    
    // Group
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(563)
      ),
      subitem: item,
      count: 1
    )
    
    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .none
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 0)
    
    return section
  }
  
  internal func createMovieCastMemberLayout() -> NSCollectionLayoutSection {
    // Item
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    ))
    
    // Group
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(871)
      ),
      subitem: item,
      count: 1
    )
    
    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .none
    
    return section
  }
  
  internal func configureDataSource() {
    datasource = MovieDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, movie in
      
      return self?.createMovieDetailCell(at: indexPath, movie: movie)
//      guard let self else { return nil }
      
//      switch indexPath.section {
//      case 0:
//        return self.createTopRatedMovieCell(at: indexPath, movie: movie)
//      default:
//        return self.createDefaultMovieCell(at: indexPath, movie: movie)
//      }
    }
    
//    datasource.supplementaryViewProvider = configureSupplementaryViewProvider
  }
  
  private func createMovieDetailCell(at indexPath: IndexPath, movie: MovieDetail) -> UICollectionViewCell? {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MovieDetailBackgroundCell.reusableId,
      for: indexPath
    ) as? MovieDetailBackgroundCell
    
    guard let cell else { return nil }
    
    cell.backgroundColor = .systemPink
    cell.updateData(with: movie)
    
    return cell
  }
  
  internal func updateCollectionViewData(
    with movieDetail: MovieDetail,
    for section: MovieDetailSection
  ) {
    var snapshot = NSDiffableDataSourceSectionSnapshot<MovieDetail>()
    snapshot.append([movieDetail])
    
    DispatchQueue.main.async {
      self.datasource.apply(snapshot, to: section)
    }
  }
}
