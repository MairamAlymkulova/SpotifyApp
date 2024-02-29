//
//  Playlist.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation

struct Playlist: Codable {
    let description: String?
    let externalUrls: [String: String]?
    let id: String?
    let images: [APIImage]?
    let name: String
    let owner: User?

    enum CodingKeys: String, CodingKey {
        case description
        case externalUrls = "external_urls"
        case id
        case images
        case name
        case owner
    }
}

struct PlaylistDetails: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    let tracks: PlaylistTracks

    enum CodingKeys: String, CodingKey {
        case description
        case externalUrls = "external_urls"
        case id
        case images
        case name
        case owner
        case tracks
    }
}

struct PlaylistTracks: Codable {
    let items: [PlaylistItems]
}

struct PlaylistItems: Codable {
    let track: AudioTrack
}
