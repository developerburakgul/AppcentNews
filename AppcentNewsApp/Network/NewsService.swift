//
//  NewsService.swift
//  AppcentNewsApp
//
//  Created by Mert Ozseven on 24.01.2025.
//

import Foundation

// MARK: - NewsServiceProtocol

protocol NewsServiceProtocol {
    func fetchNews(searchString: String) async throws -> [Article]
}

final class NewsService {
    private let api: API

    init(api: API = API.shared) {
        self.api = api
    }
}

// MARK: - NetworkManagerProtocol

extension NewsService: NewsServiceProtocol {
    func fetchNews(searchString: String) async throws -> [Article] {
        // We expect a Response that contains `[Article]` inside
        let response: Response = try await api.executeRequestFor(
            router: .news(query: searchString),
            method: .get
        )
        return response.articles
    }
}


