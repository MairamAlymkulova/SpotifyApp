//
//  PodcastsManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import Foundation
import Alamofire

class PodcastsManager {
    static let shared = PodcastsManager()
    
    private init() { }
    
    func getPodcasts(completion: @escaping ([PodcastData]) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            
            AF.request(APIUrlConstants.episodesURL, headers: headers).responseJSON { response in

                switch response.result {
                case .success(let value):
                    // Обработка успешного ответа
                    if let json = value as? [String: Any], let items = json["items"] as? [[String: Any]] {
//                        print("Items Count: \(items.count)")
                        let firstSixEpisodes = items.prefix(6)
                        let podcastInfo = firstSixEpisodes.compactMap { item -> PodcastData? in
//                            print("Inside CompactMap")
//                            print("Item: \(item)")
                            if let show = item["episode"] as? [String: Any],
                               let name = show["name"] as? String,
                               let description = show["description"] as? String,
                               let duration = show["duration_ms"] as? Int,
                               let date = show["release_date"] as? String,
                               //let date = ISO8601DateFormatter().date(from: dateStr),
                               //let artists = show["publisher"] as? String,
                                let images = show["images"] as? [[String: Any]],
                               let imageUrl = images.first?["url"] as? String {
                                return PodcastData(name: name, description: description, duration: duration, date: date, imageUrl: imageUrl)
                            } else {
                                return nil
                            }
                        }
                        
                        // Вывод результатов
                        for podcastData in podcastInfo {
                            print("Название подкаста: \(podcastData.name)")
                        }
                        
                        // Вызываем блок завершения с полученными данными о подкастах
                        completion(podcastInfo)
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
