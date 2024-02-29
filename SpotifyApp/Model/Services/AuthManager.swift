//
//  AuthManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 2/1/24.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    private init() { }
    
    private var refreshingToken = false
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        
        let string = "\(base)?response_type=code&client_id=\(APIUrlConstants.clientID)&scope=\(APIUrlConstants.scopes)&redirect_uri=\(APIUrlConstants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool{
        guard let expirationDate = tokenExpirationDate else{
            return false
        }
        let currentDate = Date()
        let fiveMinute: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinute) >= expirationDate
    }
    
    public func exchangeCodeToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ){
        guard let url = URL( string: APIUrlConstants.tokenAPIURL) else{
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: APIUrlConstants.redirectURI),
        ]
        var request = URLRequest(url: url)
        request.httpMethod  = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = APIUrlConstants.clientID + ":" + APIUrlConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let basic64String = data?.base64EncodedString() else{
            completion(false)
            return
        }
        request.setValue("Basic \(basic64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            
            do{
                print(String(data: data, encoding: .utf8) ?? "Empty data")

                let result = try JSONDecoder().decode(AuthResponse.self, from: data)

                self?.cachToken(result: result)

                completion(true)
            }
            catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void){
        guard !refreshingToken else{
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken{
            refreshIfNeeded { success in
                if let token = self.accessToken, success{
                    completion(token)
                }
                
            }
        }else if let token = accessToken{
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: @escaping(Bool) -> Void) {
        
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion(false)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        guard let url = URL( string: APIUrlConstants.tokenAPIURL) else{
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        var request = URLRequest(url: url)
        request.httpMethod  = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = APIUrlConstants.clientID + ":" + APIUrlConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let basic64String = data?.base64EncodedString() else{
            completion(false)
            return
        }
        request.setValue("Basic \(basic64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            
            self?.refreshingToken = false
            
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            
            do{
                print(String(data: data, encoding: .utf8) ?? "Empty data")

                let result = try JSONDecoder().decode(AuthResponse.self, from: data)

                self?.onRefreshBlocks.forEach({$0(result.access_token)})
                self?.onRefreshBlocks.removeAll()
                self?.cachToken(result: result)

                completion(true)
            }
            catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private func cachToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if result.refresh_token != nil{
            UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")

        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    
    }
    
}
