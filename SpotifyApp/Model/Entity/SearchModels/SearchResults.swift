//
//  SearchResults.swift
//  SpotifyApp
//
//  Created by A Mairam on 3/1/24.
//

import Foundation


enum SearchResults{
    case album(model: Album)
    case artist(model: Artist)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
    
    var name: String {
        switch self {
        case .track(let model): return model.name
        case .album(let model): return model.name
        case .playlist(let model): return model.name
        case .artist(let model): return model.name
        }
    }
}
