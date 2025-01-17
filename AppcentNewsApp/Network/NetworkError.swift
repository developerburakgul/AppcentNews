//
//  NetworkError.swift
//  AppcentNewsApp
//
//  Created by Yunus Oktay on 17.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case requestFailed
    case jsonDecodedError
    case customError(Error)
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .requestFailed:
            return "Request Failed. Please check your internet connection."
        case .jsonDecodedError:
            return "Failed to decode JSON data."
        case .customError(let error):
            return error.localizedDescription
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
