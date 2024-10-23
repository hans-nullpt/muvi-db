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
      let topInset = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) + 40
      
      make.top.equalTo(view.snp.top).offset(-topInset)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    collectionView.register(
      MovieDetailBackgroundCell.nib(),
      forCellWithReuseIdentifier: MovieDetailBackgroundCell.reusableId
    )
    
    collectionView.register(
      CastMemberCell.nib(),
      forCellWithReuseIdentifier: CastMemberCell.reusableId
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
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      ),
      subitem: item,
      count: 1
    )
    
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.9),
        heightDimension: .absolute(134)
      ),
      subitem: verticalGroup,
      count: 3
    )
    horizontalGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
    
    // Section
    let section = NSCollectionLayoutSection(group: horizontalGroup)
    section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 32, trailing: 20)
    section.orthogonalScrollingBehavior = .continuous
    section.interGroupSpacing = 8
    
    return section
  }
  
  internal func configureDataSource() {
    datasource = MovieDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, movie in
      print(indexPath.section)
      
      guard let self else { return UICollectionViewCell() }
      
      if let detail = movie as? MovieDetail {
        return self.createMovieDetailCell(at: indexPath, movie: detail)
      }
      
      if let company = movie as? ProductionCompanies {
        return self.createMovieCastMemberCell(at: indexPath, member: company)
      }
      
      return nil
    }
    
  }
  
  private func createMovieDetailCell(at indexPath: IndexPath, movie: MovieDetail) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MovieDetailBackgroundCell.reusableId,
      for: indexPath
    ) as? MovieDetailBackgroundCell
    
    guard let cell else { return UICollectionViewCell() }
    
    cell.backgroundColor = .systemPink
    cell.updateData(with: movie)
    cell.addToFavoriteBtn?.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
    
    return cell
  }
  
  private func createMovieCastMemberCell(at indexPath: IndexPath, member: ProductionCompanies) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CastMemberCell.reusableId,
      for: indexPath
    ) as? CastMemberCell
    
    guard let cell else { return UICollectionViewCell() }
    
    cell.updateData(with: member)
    
    return cell
  }
  
  internal func updateCollectionViewData(
    with items: [AnyHashable],
    for section: MovieDetailSection
  ) {
    var snapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
    
    snapshot.append(items)
    
    self.datasource.apply(snapshot, to: section)
    
  }
}
