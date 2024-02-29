//
//  SearchResults.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation


struct SearchResulsResponse: Codable {
    let albums: SearchAlbum
    let artists: SearchArtists
    let playlists: SearchPlaylists
    let tracks: SearchTracks
}

struct SearchAlbum: Codable {
    let items: [Album]
}

struct SearchArtists: Codable {
    let items: [Artist]
}

struct SearchPlaylists: Codable {
    let items: [Playlist]
}

struct SearchTracks: Codable {
    let items: [AudioTrack]
}
