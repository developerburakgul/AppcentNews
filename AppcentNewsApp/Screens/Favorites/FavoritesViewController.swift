//
//  FavoritesViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.01.2025.
//

import Foundation
import UIKit


class FavoritesViewController: UIViewController {
    private var viewModel: FavoritesViewModelProtocol = FavoritesViewModel()
    //MARK: - UI ELEMENTS
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsDetailCell.self, forCellReuseIdentifier: NewsDetailCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        title = "FAVORİTES"
        
    }
}


//MARK: -  UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: - TODO
        // convert to dequeReusableCell
        var cell = NewsDetailCell()
        let news = viewModel.getData(at: indexPath)
        cell.configureWith(news)
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.getData(at: indexPath)
        let detailViewController = DetailViewController(news: news)
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
}

#Preview() {
    FavoritesViewController()
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
