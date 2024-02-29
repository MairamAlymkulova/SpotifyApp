//
//  SearchView+Extention.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = results[indexPath.row]
        switch result {
        case .artist(model: let model):
            guard let artistsCell = tableView.dequeueReusableCell(
                withIdentifier: "artistsCell",
                for: indexPath
            ) as? CustomArtistsTableViewCell
                    
             else {
                return UITableViewCell()
            }
            
            artistsCell.setValues(result: model)
            return artistsCell
            
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cell,
                for: indexPath
            ) as? CustomSearchResultsTableViewCell
                    
             else {
                return UITableViewCell()
            }
            cell.setValues(result: result)
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = results[indexPath.row]
        
        delegate?.didTapResults(result)
        
        
    }
    
}

