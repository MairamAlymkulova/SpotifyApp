//
//  SearchViewControllerCollectionView+Extantion.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = categories?[indexPath.row] else {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath
        )as? CustomCollectionViewCell else{
            
            return UICollectionViewCell()
        }
        

        cell.configure(category: category)
        
        return cell
    }
    
    
}
