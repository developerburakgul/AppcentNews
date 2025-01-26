//
//  NetworkManager.swift
//  AppcentNewsApp
//
//  Created by Mert Ozseven on 24.01.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func execute<T: Decodable>(urlRequest: URLRequest) async throws -> T
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
    func execute<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                print("Decoding error: \(error)")
                throw NetworkError.decodingError
            }
        } catch {
            // If the request itself fails (e.g., no internet)
            throw NetworkError.customError(error)
        }
    }
}
