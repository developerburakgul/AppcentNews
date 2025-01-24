//
//  NewsViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.01.2025.
//


//MARK: - Todo
/*
 Viewmodel nasıl inject edilcek ???
 TableViewCEll i deque ya çevrilcek
 searchbar eklencek

 */
import Foundation
import UIKit

protocol NewsViewModelOutputProtocol: AnyObject {
    var dataSourceCount: Int { get }
    func getData(at indexPath: IndexPath) -> Article
}

final class NewsViewController: UIViewController {

    private var viewModel: NewsViewModel = NewsViewModel()

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
        viewModel.fetchNews(searchString: "apple")
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

extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.getData(at: indexPath)
        let detailViewController = DetailViewController(article: article)
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
