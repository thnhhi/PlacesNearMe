//
//  APIError.swift
//  PlacesNearMe
//
//  Created by VTVH on 22/7/25.
//

enum APIError: Error {
    case invalidURL
    case encodingError
    case mappingFailed
    case serverError(String)
    case networkError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "❌ Invalid URL."
        case .encodingError:
            return "❌ Failed to encode parameters."
        case .mappingFailed:
            return "❌ Failed to map response to model."
        case .serverError(let message):
            return "❌ Server Error: \(message)"
        case .networkError(let error):
            return "❌ Network Error: \(error.localizedDescription)"
        }
    }
}
