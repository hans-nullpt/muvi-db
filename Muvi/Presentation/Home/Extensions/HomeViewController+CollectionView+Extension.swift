//
//  HomeViewController+CollectionView+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

extension HomeViewController {
    internal func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
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
