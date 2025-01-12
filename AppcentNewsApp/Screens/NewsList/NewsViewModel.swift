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
    func getData(at indexPath: IndexPath) -> News
}

class NewsViewModel: NewsViewModelProtocol {
    var dataSource: [News] = []
    
    init() {
        
    }
    
    var dataSourceCount: Int {
        dataSource.count
    }
    
    func getData(at indexPath: IndexPath) -> News {
        dataSource[indexPath.row]
    }
    
    
}
