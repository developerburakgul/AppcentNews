//
//  NewsService.swift
//  AppcentNewsApp
//
//  Created by Mert Ozseven on 24.01.2025.
//

import Foundation

// MARK: - NewsServiceProtocol

protocol NewsServiceProtocol {
    func fetchNews(
        searchString: String,
        completion: @escaping (Result<[Article], NetworkError>) -> Void
    )
}

final class NewsService {
    private let api: API

    init(api: API = API.shared) {
        self.api = api
    }
}

// MARK: - NetworkManagerProtocol

extension NewsService: NewsServiceProtocol {
    func fetchNews(searchString: String, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        api.executeRequestFor(
            router: .news(query: searchString),
            method: .get,
            completion: completion
        )
    }
}


