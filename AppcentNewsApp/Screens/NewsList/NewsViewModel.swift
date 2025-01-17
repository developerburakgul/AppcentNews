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

protocol NewsViewModelProtocol: AnyObject {
    var dataSourceCount: Int { get }
    func getData(at indexPath: IndexPath) -> Article
}

class NewsViewModel: NewsViewModelProtocol {
    let service = Service()
    var dataSource: [Article] = []
    
    init() {
        
    }
    
    var dataSourceCount: Int {
        dataSource.count
    }
    
    func getData(at indexPath: IndexPath) -> Article {
        dataSource[indexPath.row]
    }
    
    func getNews() {
        service.getNews(country: "us") { result in
            print(result)
        }
    }
    
}
