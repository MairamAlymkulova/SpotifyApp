//
//  AlbumManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import Foundation
import Alamofire

class AlbumManager {
    static let shared = AlbumManager()
    
    private init() { }
    
    func getNewAlbums(completion: @escaping ([AlbumsData]) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            AF.request(APIUrlConstants.newReleasesURL, headers: headers).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], let albums = json["albums"] as? [String: Any], let items = albums["items"] as? [[String: Any]] {
//                        print("Albums Count: \(items.count)")
                        let newAlbumInfo = items.compactMap { item -> AlbumsData? in
//                            print("Inside CompactMap")
//                            print("Item: \(item)")
                            if let name = item["name"] as? String,
                               let artists = item["artists"] as? [[String: Any]],
                               let artistName = artists.first?["name"] as? String,
                               let images = item["images"] as? [[String: Any]],
                               let imageUrl = images.first?["url"] as? String {
                                return AlbumsData(name: name, artist: artistName, imageUrl: imageUrl)
                            } else {
                                return nil
                            }
                        }
                        
                        // Вывод результатов
//                        for albumData in newAlbumInfo {
//                            print("Название альбома: \(albumData.name), Артист: \(albumData.artist), Изображение: \(albumData.imageUrl)")
//                        }
                        
                        // Вызываем блок завершения с полученными данными о новых альбомах
                        completion(newAlbumInfo)
                    }
                case .failure(let error):
                    // Обработка ошибки
                    print("Ошибка при запросе: \(error)")
                    // Вызываем блок завершения с пустым массивом
                    completion([])
                }
            }
        }
        
    }
}
