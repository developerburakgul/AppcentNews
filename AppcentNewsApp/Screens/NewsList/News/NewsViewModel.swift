//
//  NewsViewModel.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 12.01.2025.
//


//MARK: - Todo
/*
 service kısımlaro network katmanı ?
 */
import Foundation

protocol NewsViewModelInputProtocol: AnyObject {
    func fetchNews(searchString: String) async
}


final class NewsViewModel: NewsViewModelOutputProtocol {

    // MARK: Properties
    var dataSource: [Article] = []
    private let service: NewsServiceProtocol

    init(service: NewsServiceProtocol = NewsService()) {
        self.service = service
    }

    var dataSourceCount: Int {
        dataSource.count
    }

    func getData(at indexPath: IndexPath) -> Article {
        dataSource[indexPath.row]
    }
}

extension NewsViewModel: NewsViewModelInputProtocol {

    func fetchNews(searchString: String) {
        Task {
            do {
                let articles = try await service.fetchNews(searchString: searchString)
                dataSource = articles
                dump(dataSource)
            } catch {
                print("Error fetching news: \(error.localizedDescription)")
            }
        }
    }
}
