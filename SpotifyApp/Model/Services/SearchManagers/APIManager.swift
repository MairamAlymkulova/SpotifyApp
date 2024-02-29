//
//  APIManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 16/2/24.
//

import Foundation


class APIManager {
    static var shared = APIManager()
    
    func getData <T: Decodable> (for requestType: T.Type, url: String, completion: @escaping (Result< T, Error>) -> Void)  {
        
        APIService.shared.createRequest(
            url: URL(string: url),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request){data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(SearchError.invalidURL))
                        return
                    }
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                        print(json)
                        let result = try decoder.decode(T.self, from: data)
                        
                        completion(.success(result))
                        
                    } catch {
                        print("Error decoding process \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
        
    }
}
