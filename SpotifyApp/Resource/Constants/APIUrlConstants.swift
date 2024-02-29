//
//  Constants.swift
//  SpotifyApp
//
//  Created by A Mairam on 2/1/24.
//

import Foundation
import Alamofire

struct APIUrlConstants {

    //    static let clientID = "e06a5382a6b64b4a90bc0271786dfe0f"
    //    static let clientSecret = "27984a1a1060481b82f57b9af55dfd17"
        //    static let redirectURI = "http://localhost/callback"
    
    static let baseAPIURL = "https://api.spotify.com/v1"
    static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    static let clientID = "7133ef76b2bd4e63a7dfd77784589220"
    static let clientSecret = "cf58416109d64366adb0de458f69da90"
    
    static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-read%20user-library-modify%20user-read-email%20user-top-read%20user-read-recently-played"
    
    
    static let redirectURI = "https://www.youtube.com"
    
    static let songsURL = baseAPIURL + "/me/tracks"
    static let episodesURL = baseAPIURL + "/me/episodes"
    static let newReleasesURL = baseAPIURL + "/browse/new-releases"

    
    
    
    static let profileUrl = baseAPIURL + "/me"
    static let userTracksUrl = baseAPIURL + "/me/tracks"
    static let userTracksContainsUrl = baseAPIURL + "/me/tracks/contains"
    
    static let userTopTracksUrl = baseAPIURL + "/me/top/tracks"
    static let userTopArtistUrl = baseAPIURL + "/me/top/artists"
    
    static let artistUrl = baseAPIURL + "/artists"
    
    static let featurePlaylistUrl = baseAPIURL + "/browse/featured-playlists?country=us&limit=50"
    static let recommendationsGenreUrl = baseAPIURL + "/recommendations/available-genre-seeds"
    static let recommendationsUrl = baseAPIURL + "/recommendations?country=IN&limit=40"
    static let albumDetailsUrl = baseAPIURL + "/albums/"
    static let myAlbumstUrl = baseAPIURL + "/me/albums"
    static let myPlaylistUrl = baseAPIURL + "/me/playlists"
    static let playlistDetailsUrl = baseAPIURL + "/playlists/"
    static let categoryUrl = baseAPIURL + "/browse/categories"
    static let searchUrl = baseAPIURL + "/search?type=album,artist,playlist,track&limit=10"
}
