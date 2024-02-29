//
//  Categories.swift
//  SpotifyApp
//
//  Created by A Mairam on 8/1/24.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: Category
}

struct Category: Codable {
    let href: String
    let items: [CategoryItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct CategoryItem: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
