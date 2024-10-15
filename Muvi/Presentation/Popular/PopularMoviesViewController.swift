//
//  PopularMoviesViewController.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

class PopularMoviesViewController: UIViewController {
  typealias MovieDataSource = UICollectionViewDiffableDataSource<Int, Movie>
  
  private let label = UILabel()
  internal var collectionView: UICollectionView!
  internal var datasource: MovieDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLabel()
    configureCollectionView()
    configureDataSource()
    
    updateCollectionViewData(with: [Movie(id: 1), Movie(id: 2), Movie(id: 3)])
  }
  
  private func configureLabel() {
    view.addSubview(label)
    
    label.font = .preferredFont(forTextStyle: .title2)
    label.textColor = .white
    label.text = "Popular Movies"
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  internal func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMovieGridFlowLayout())
    
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    collectionView.register(MovieGridCell.nib(), forCellWithReuseIdentifier: MovieGridCell.reusableId)
    
  }
  
  internal func createMovieGridFlowLayout() -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
    let itemWidth = availableWidth / 2
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    
    return flowLayout
  }
  
  internal func configureDataSource() {
    datasource = MovieDataSource(collectionView: collectionView) { collectionView, indexPath, movie in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCell.reusableId, for: indexPath) as? MovieGridCell
      
      guard let cell else { return UICollectionViewCell() }
      
      cell.updateData(with: movie)
      
      return cell
    }
    
  }
  
  internal func updateCollectionViewData(
    with movies: [Movie]
  ) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
    snapshot.appendSections([0])
    snapshot.appendItems(movies)
    
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      
      self.datasource.apply(snapshot)
      
    }
    
  }
  
}
