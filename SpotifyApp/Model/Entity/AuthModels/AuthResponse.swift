//
//  AuthResponse.swift
//  SpotifyApp
//
//  Created by A Mairam on 2/1/24.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
}


