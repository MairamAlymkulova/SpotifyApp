//
//  SearchViewController+SerchResultsUpdatingExtantion.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        resultsController.delegate = self
        SearchService.shared.search(query: query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let results):
                    resultsController.update(with: results)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: searchController)
        
        if searchText.isEmpty {
            searchController.searchResultsController?.view.isHidden = true
        } else {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    
}

extension SearchViewController: SearchResultsViewControllerDelegate{
    func didTapResults(_ result: SearchResults) {
        
        switch result{
        case .album(model: let model):
            
            APIManager.shared.getData(for: AlbumDetails.self, url: APIUrlConstants.albumDetailsUrl + model.id) { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let album):
                        var tracks = album.tracks.items
                        
                        tracks = tracks.map { track in
                            var modifiedTrack = track
                            modifiedTrack.album = model
                            return modifiedTrack
                        }

                        let vc = AlbumViewController(tracks: tracks)
                        vc.setValues(album: album)
                        self.navigationController?.pushViewController(vc, animated: true)
                    case .failure(let error):
                        print(error.localizedDescription)

                    }
                }
            }
            
            
        case .artist(model: let model):
            break
            
        case .playlist(model: let model):
            
            APIManager.shared.getData(for: PlaylistDetails.self, url: APIUrlConstants.playlistDetailsUrl + "\(model.id ?? "")") { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let results):
                        let vc = PlaylistViewController(playlist: results)
                        vc.setValues(playList: results)
                        self.navigationController?.pushViewController(vc, animated: true)
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                    }
                }
            }

        case .track(model: let model):
            PlayerPresenter.shared.startPlayback(from: self, track: model)
        }
    }
}
