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

//protocol NewsViewModelInputProtocol: AnyObject {
//    func fetchNews(searchString: String)
//}

protocol NewsViewModelProtocol: AnyObject {
    var view: NewsViewControllerProtocol? { get set }
    var searchText: String? { get set }
    var dataSourceCount: Int { get }
    func getData(at indexPath: IndexPath) -> Article
    func fetchNews(searchString: String)
    func loadData()
}

class NewsViewModel {
    
    // MARK: Properties
    weak var view: NewsViewControllerProtocol?
    var dataSource: [Article] = []
    var searchText: String?
    private let service: NewsServiceProtocol

    init(service: NewsServiceProtocol = NewsService()) {
        self.service = service
    }
    
    private var page: Int = 1
    private var pageSize: Int = 5
    
        
}


extension NewsViewModel: NewsViewModelProtocol {
    
    

    
    
    
    var dataSourceCount: Int {
        dataSource.count
    }

    func getData(at indexPath: IndexPath) -> Article {
        dataSource[indexPath.row]
    }
    
    func fetchNews(searchString: String) {
        searchText = searchString
        service.fetchNews(
            searchString: searchString,
            page: page,
            pageSize: pageSize
        ) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let AppcentResponse):
                let data =  AppcentResponse.articles
                self.dataSource += data
                self.view?.reloadData()
            case .failure(let error):
                print(NetworkError.customError(error))
            }
        }
        
        print(self.dataSourceCount)
    }
    
    func loadData() {
        guard let searchText else {return}
        page += 1
        fetchNews(searchString: searchText)
        
    }


}

