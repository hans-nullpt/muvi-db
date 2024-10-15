//
//  HomeViewController+CollectionView+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

extension HomeViewController {
  internal func configureCollectionView() {
    collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: UICollectionViewCompositionalLayout { [weak self] index, _ in
        index == 0 ? self?.createTopRatedMovieLayout() : self?.createDefaultMovieLayout()
      }
    )
    
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    collectionView.register(
      TopRatedMovieCell.self,
      forCellWithReuseIdentifier: TopRatedMovieCell.reusabledId
    )
    collectionView.register(
      MovieCell.self,
      forCellWithReuseIdentifier: MovieCell.reusabledId
    )
    collectionView.register(
      HeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: HeaderCollectionReusableView.reusableId
    )
    
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    
  }
  
  private func createTopRatedMovieLayout() -> NSCollectionLayoutSection {
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
  }
  
  private func createDefaultMovieLayout() -> NSCollectionLayoutSection {
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
        widthDimension: .fractionalWidth(0.85),
        heightDimension: .absolute(157)
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
    section.boundarySupplementaryItems = supplementaryViews
    
    return section
  }
  
  internal func configureDataSource() {
    datasource = MovieDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, movie in
      guard let self else { return nil }
      
      switch indexPath.section {
      case 0:
        return self.createTopRatedMovieCell(at: indexPath, movie: movie)
      default:
        return self.createDefaultMovieCell(at: indexPath, movie: movie)
      }
    }
    
    datasource.supplementaryViewProvider = configureSupplementaryViewProvider
  }
  
  internal func updateCollectionViewData(
    with movies: [Movie],
    for section: MovieSection
  ) {
    var snapshot = NSDiffableDataSourceSectionSnapshot<Movie>()
    snapshot.append(movies)
    
    DispatchQueue.main.async {
      self.datasource.apply(snapshot, to: section)
    }
  }
  
  private func createTopRatedMovieCell(at indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TopRatedMovieCell.reusabledId,
      for: indexPath
    ) as? TopRatedMovieCell
    
    guard let cell else { return nil }
    
    cell.backgroundColor = .systemPink
    cell.updateData(with: movie)
    
    return cell
  }
  
  private func createDefaultMovieCell(at indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MovieCell.reusabledId,
      for: indexPath
    ) as? MovieCell
    
    guard let cell else { return nil }
    
    cell.backgroundColor = .systemGreen
    cell.updateData(with: movie)
    
    return cell
  }
  
  private func configureSupplementaryViewProvider(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
    
    guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: HeaderCollectionReusableView.reusableId,
      for: indexPath
    ) as? HeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    
    let section = MovieSection.allCases[indexPath.section]
    supplementaryView.setTitle(section.title)
    
    return supplementaryView
    
  }
}

extension HomeViewController: UICollectionViewDelegate {
  
}
