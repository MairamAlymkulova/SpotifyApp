//
//  AccessTokenResponse.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import Foundation

struct AccessTokenResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    // Другие поля, если они необходимы
}
