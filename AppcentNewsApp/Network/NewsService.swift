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
        page: Int,
        pageSize: Int,
        completion: @escaping (Result<AppcentResponse, NetworkError>) -> Void
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
    func fetchNews(
        searchString: String,
        page: Int = 1,
        pageSize: Int = 100,
        completion: @escaping (Result<AppcentResponse, NetworkError>) -> Void
    ) {
        api.executeRequestFor(
            AppcentResponse.self,
            router: .news(query: searchString, page: page, pageSize: pageSize),
            method: .get,
            completion: completion
        )
    }
}


