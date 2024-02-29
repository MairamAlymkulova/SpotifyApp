//
//  TracksManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import Foundation
import Alamofire


class TracksManager {
    static let shared = TracksManager()
    
    private init() { }
    
    func getSongs(completion: @escaping ([TrackData]) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            AF.request(APIUrlConstants.songsURL, headers: headers).responseJSON { response in
              
                switch response.result {
                    
                case .success(let value):
                    // Обработка успешного ответа
                    if let json = value as? [String: Any], let items = json["items"] as? [[String: Any]] {
                        
                        // Первые шесть песен
                        let firstSixSongs = items.prefix(6)
                        
                        // Получение названий песен
                        let songInfo = firstSixSongs.compactMap { item -> TrackData? in
                            if let track = item["track"] as? [String: Any],
                               let name = track["name"] as? String,
                               let artists = track["artists"] as? [[String: Any]],
                               let artistName = artists.first?["name"] as? String,
                               let images = track["album"] as? [String: Any],
                               let imageArray = images["images"] as? [[String: Any]],
                               let imageUrl = imageArray.first?["url"] as? String {
                                return TrackData(name: name, artist: artistName, imageUrl: imageUrl)
                            }
                            return nil
                        }
                        
                        // Вывод результатов
//                        for trackData in songInfo {
//                            print("Название песни: \(trackData.name), Артист: \(trackData.artist), Изображение: \(trackData.imageUrl)")
//                        }
                        
                        // Обновляем массив треков и вызываем блок завершения
                        completion(songInfo)
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
