//
//  HomeViewController+CollectionView+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        
        switch section {
            
        case .topRated(items: let items):
            return min(items.count, 5)
        case .popular(items: let items):
            return items.count
        case .upcoming(items: let items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        switch section {
            
        case .topRated(items: let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedMovieCell.reusabledId, for: indexPath) as? TopRatedMovieCell
            
            guard let cell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .systemPink
            cell.updateData(with: items[indexPath.item])
            
            return cell
        case .popular(items: let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusabledId, for: indexPath) as? MovieCell
            
            guard let cell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.updateData(with: items[indexPath.item])
            
            return cell
        case .upcoming(items: let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusabledId, for: indexPath) as? MovieCell
            
            guard let cell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .systemGreen
            cell.updateData(with: items[indexPath.item])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionReusableView.reusableId,
            for: indexPath
        ) as? HeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let section = sections[indexPath.section]
        print(section.title)
        supplementaryView.setTitle(section.title)
        
        return supplementaryView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
}
