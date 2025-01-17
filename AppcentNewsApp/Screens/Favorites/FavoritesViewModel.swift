//
//  FavoritesViewModel.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 12.01.2025.
//

import Foundation

//DEPENDENCY INVERSION
//DEPENDENCY INJECTION

protocol FavoritesViewModelProtocol: AnyObject {
    var dataSourceCount: Int { get }
    func getData(at indexPath: IndexPath) -> Article
}

class FavoritesViewModel:  FavoritesViewModelProtocol {
    
    
    var dataSourceCount: Int {
        10
    }
    
    func getData(at indexPath: IndexPath) -> Article {
        Article(
            source: Source(id: "1", name: "Burak"),
            author: "Batuhan",
            title: "Başlık",
            description: "Detay",
            url: "sdfsdf",
            urlToImage: "dsfsdf",
            publishedAt: "Date()",
            content: "sdfsdfsdfsdf"
        )
        
    }
    

}

class Yigit: FavoritesViewModelProtocol {
    var dataSourceCount: Int {
        10
    }
    
    func getData(at indexPath: IndexPath) -> Article {
        Article(
            source: Source(id: "2", name: "Yiğit"),
            author: "xx",
            title: "Başlık",
            description: "Detay",
            url: "sdfsdf",
            urlToImage: "dsfsdf",
            publishedAt: "Date",
            content: "sdfsdfsdfsdf"
        )
    }
    
    
}
