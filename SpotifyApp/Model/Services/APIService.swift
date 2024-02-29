//
//  APIService.swift
//  SpotifyApp
//
//  Created by A Mairam on 28/12/23.
//

import Foundation

class APIService{
    static let shared = APIService()
    private init() { }
    

    func createRequest(
        url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ){
        AuthManager.shared.withValidToken { token in
            
            guard let apiURl = url else {
                return
            }
            var request = URLRequest(url: apiURl)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.timeoutInterval = 30
            completion(request)
        }
        
    }
    
}
