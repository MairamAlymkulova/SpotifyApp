//
//  HTTPMethodEnum.swift
//  SpotifyApp
//
//  Created by A Mairam on 29/12/23.
//

import Foundation

enum HTTPMethod: String {
    case POST
    case GET
}

enum SearchError: Error {
    case invalidURL
    case unknownError
}
