//
//  User.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation

struct User: Codable {
    let displayName: String
    let id: String
    let externalUrls: [String: String]
    let type: String

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case id
        case externalUrls = "external_urls"
        case type
    }
}
