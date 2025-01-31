//
//  NetworkManager.swift
//  AppcentNewsApp
//
//  Created by Mert Ozseven on 24.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case requestFailed
    case decodingError
    case noData
    case customError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .requestFailed:
            return "Request Failed"
        case .decodingError:
            return "Decoding Error"
        case .customError(let error):
            return error.localizedDescription
        case .noData:
            return "No data received"
        }
    }
}

protocol NetworkManagerProtocol {
    func execute<T: Codable>(
        _ T: T.Type,
        urlRequest: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkManager {
    private let session: URLSession

    // MARK: init

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
    
    /// ##Usage
    /// - Parameters:
    ///   - urlRequest: Requesti buraya verelim
    ///   - completion: Completion bloğu
    func execute<T: Codable>(_ T: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.customError(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                print("No data received")
                completion(.failure(.noData))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON Response: \(jsonString)")
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    
    
    }
}
