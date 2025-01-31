//
//  API.swift
//  AppcentNewsApp
//
//  Created by Mert Ozseven on 24.01.2025.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Router {
    case news(query: String, page: Int = 1, pageSize: Int = 100)

    var path: String {
        switch self {
        case .news:
            return "v2/everything"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .news(let query, let page, let pageSize):
            return [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "pageSize", value: "\(pageSize)"),
                URLQueryItem(name: "apiKey", value: API.shared.apiKey)
                
            ]
        }
    }
}

final class API {

    // MARK: Singleton

    static let shared: API = {
        let instance = API()
        return instance
    }()

    // MARK: Properties
    fileprivate let apiKey = "773153e605234b7bae3f92a77d65f772"
    private let baseURL = "https://newsapi.org/"

    var service: NetworkManagerProtocol

    // MARK: init

    init(service: NetworkManagerProtocol = NetworkManager()) {
        self.service = service
    }
}

extension API {
    func prepareURLRequestFor(
        router: Router,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest?  {

        let urlString = baseURL + router.path
        print(urlString)
        guard var urlComponents = URLComponents(string: urlString) else { return nil }

        urlComponents.queryItems = router.queryItems

        guard let url = urlComponents.url else { return nil }
print(url)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    func executeRequestFor<T: Codable>(_ T: T.Type, router: Router, headers: [String: String]? = nil, method: RequestMethod = .get, completion: @escaping (Result<T, NetworkError>) -> Void) {

        guard let urlRequest = prepareURLRequestFor(router: router, headers: headers, method: method) else {
            completion(.failure(.invalidRequest))
            return
        }

        service.execute(T, urlRequest: urlRequest) { (result: Result<T, NetworkError>) in
            completion(result)
        }
        
//
//        service.execute(
//            T.Type,
//            urlRequest: urlRequest) { result: Result<T.Type, NetworkError> in
//                completion(result)
//            }

    }
}
