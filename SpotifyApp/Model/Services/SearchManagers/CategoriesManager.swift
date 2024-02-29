//
//  CategoriesManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 8/1/24.
//

import UIKit

class CategoriesManager{
    
    static let shared = CategoriesManager()
    private init() { }
    
    func getAllCategories (completion: @escaping (Result<CategoryResponse, Error>) -> Void) {
        
        APIService.shared.createRequest(
            url: URL(string: Constants.categoryUrl),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request){data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(SearchError.invalidURL))
                        return
                    }
                    
                    do {
                        let json = try JSONDecoder().decode(CategoryResponse.self, from: data)
                        completion(.success(json))
                        
                    } catch {
                        print("Error decoding process \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
}
