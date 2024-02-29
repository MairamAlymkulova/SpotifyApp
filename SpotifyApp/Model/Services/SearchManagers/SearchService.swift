//
//  SearchService.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation

class SearchService{
    
    static let shared = SearchService()
    private init() { }
    
    
    func search(query: String, completion: @escaping (Result<[SearchResults], Error>) -> Void) {
        APIService.shared.createRequest(
            url: URL(string: APIUrlConstants.searchUrl + "&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    if let error = error {
                        print("Network error: \(error.localizedDescription)")
                        completion(.failure(error))
                    } else {
                        print("No data received.")
                        completion(.failure(SearchError.unknownError))
                    }
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    let spotifyResponse = try decoder.decode(SearchResulsResponse.self, from: data)

                    var results: [SearchResults] = []
                                        
                    results.append(contentsOf: spotifyResponse.tracks.items.compactMap({.track(model: $0)}))
                    results.append(contentsOf: spotifyResponse.albums.items.compactMap({.album(model: $0)}))
                    results.append(contentsOf: spotifyResponse.playlists.items.compactMap({.playlist(model: $0)}))
                    results.append(contentsOf: spotifyResponse.artists.items.compactMap({.artist(model: $0)}))

                    results.sort { $0.name > $1.name}

                    

                    completion(.success(results))

                } catch {
                    print("Ошибка декодирования JSON: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

}
