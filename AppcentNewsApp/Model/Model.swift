//
//  Model.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 11.01.2025.
//

import Foundation

struct AppcentResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url, urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id, name: String?
}
