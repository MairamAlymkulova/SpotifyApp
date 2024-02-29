//
//  Model.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation
struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]?
    let id: String
    var images: [APIImage]
    let name: String
    let releaseDate: String
    let totalTracks: Int
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "availableMarkets"
        case id
        case images
        case name
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
        case artists
    }
}
struct AlbumDetails: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracksResponse

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case id
        case images
        case label
        case name
        case tracks
    }
}
