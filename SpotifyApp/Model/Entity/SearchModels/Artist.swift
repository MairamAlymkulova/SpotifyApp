//
//  Artist.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation
struct Artist: Codable {
    let href: String
    let id: String
    let name: String
    let type: String
    let externalUrls: [String: String]
    let images: [APIImage]?

    enum CodingKeys: String, CodingKey {
        case href
        case id
        case name
        case type
        case externalUrls = "external_urls"
        case images
    }
}

struct ArtistTopTracksResponse: Codable {
    let tracks: [AudioTrack]
}
