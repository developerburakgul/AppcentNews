//
//  NewsViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.01.2025.
//

import Foundation
import UIKit

extension NewsViewController {
    static func getMockData() -> [Model] {
        var data: [Model] = []
        for item in 0...100 {
            let model = Model(
                title: "\(item)",
                description: "Descripiton \(item)"
                
            )
            data.append(model)
        }
        
        return data
        
    }
}

class NewsViewController: UIViewController {
    
    private var dataSource: [Model] = []
    //MARK: - UI ELEMENTS
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsDetailCell.self, forCellReuseIdentifier: NewsDetailCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = Self.getMockData()
        setup()
        setupNavigationBar()
        
    }
    
    //MARK: - UI SETUP FUNCTIONS
    private func setup() {
        setupTableView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ]
        )
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.label]
        title = "APPCENT NEWS"
        
    }
}


//MARK: -  UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = NewsDetailCell()
        cell.configure(
            title: "iCommunity is working UIKit",
            description: "UIKit is good framework but SwiftUI is better.............. UIKit is good framework but SwiftUI is better..............",
            image: UIImage(systemName: "heart")
        )
        
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let detailViewController = DetailViewController(model: model)
        self.navigationController?.pushViewController(detailViewController, animated: false)
        
    }
}

#Preview() {
    NewsViewController()
}
#Preview("Main") {
    let newsViewController: UIViewController = NewsViewController()
    let favoritesViewController: UIViewController = FavoritesViewController()
    
    var navigationVC1 = UINavigationController(
        rootViewController: newsViewController
    )
    navigationVC1.tabBarItem = UITabBarItem(
        title: "News",
        image: UIImage(systemName: "house.fill"),
        tag: 0
    )

    
    var navigationVC2 = UINavigationController(
        rootViewController: favoritesViewController
    )
    navigationVC2.tabBarItem = UITabBarItem(
        title: "Favorites",
        image: UIImage(systemName: "heart.fill"),
        tag: 1
    )
    var tabbarController: UITabBarController = UITabBarController()
    tabbarController.viewControllers = [
        navigationVC1,
        navigationVC2
    ]
    tabbarController.tabBar.backgroundColor = .white
    return tabbarController
}
