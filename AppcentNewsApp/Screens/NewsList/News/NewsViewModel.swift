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
    func fetchNews(searchString: String)
}

class NewsViewModel: NewsViewModelOutputProtocol {

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
        service.fetchNews(searchString: searchString) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let newsResponse):
                dump(newsResponse)
            case .failure(let error):
                print(NetworkError.customError(error))
            }
        }
    }
}
