//
//  WebViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 12.01.2025.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate{

    var webView: WKWebView!
    var urlString: String
    
    //MARK: - Init
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.label]
        title = "NEWS SOURCE"
        
    }



}

#Preview() {
    UINavigationController(rootViewController: WebViewController(urlString: "https://www.icommunity.com.tr"))
}

