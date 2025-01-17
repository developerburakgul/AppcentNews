//
//  Service.swift
//  AppcentNewsApp
//
//  Created by Yunus Oktay on 17.01.2025.
//

import Foundation

class Service {
    private let apiKey = "aff86459f6114deab768d4a31e44d50a"
    private let baseURL = "https://newsapi.org/v2"
    
    private func createRequest(endpoint: String, queryItems: [URLQueryItem]? = nil) throws -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL + endpoint) else {
            throw NetworkError.invalidRequest
            return nil
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Failed to construc URL with query items.")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func getContents(endpoint: String, queryItems: [URLQueryItem], completion: @escaping ((Result<[Article], NetworkError>) -> Void)) {
        guard let request = try? createRequest(endpoint: endpoint, queryItems: queryItems) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(NetworkError.requestFailed))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                completion(.failure(NetworkError.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.requestFailed))
                return
            }
            
            do {
                let newResponse = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(newResponse.articles))
            } catch {
                completion(.failure(NetworkError.jsonDecodedError))
            }
        }.resume()
    }
    
    func getNews(country: String, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        let queryItem = [URLQueryItem(name: "country", value: country)]
        getContents(endpoint: "/top-headlines", queryItems: queryItem, completion: completion)
    }
    
    func searchNews(query: String, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        let queryItem = [URLQueryItem(name: "q", value: query)]
        getContents(endpoint: "/evertyhing", queryItems: queryItem, completion: completion)
    }
}
