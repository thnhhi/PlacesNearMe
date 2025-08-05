//
//  APIEndpoint.swift
//  PlacesNearMe
//
//  Created by VTVH on 22/7/25.
//

import Foundation

enum APIEndpoint {
    case getPlaceByCategory(type: String, keyword: String, lat: Double, lon: Double, radius: Int)
    case calculateDistances(origins: String, destinations: String)
    case getDetailPlace(place_id: String)
    case getSearch(query: String)
    
    var path: String {
        switch self {
        case .getPlaceByCategory:
            return "place/nearbysearch/json"
        case .calculateDistances:
            return "distancematrix/json"
        case .getDetailPlace:
            return "place/details/json"
        case .getSearch:
            return "place/textsearch/json"
        }
    }
    
    var method: HTTPMethodType {
        switch self {
        case .getPlaceByCategory,
             .calculateDistances,
             .getDetailPlace,
             .getSearch
            :
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPlaceByCategory(let type, let keyword, let lat, let lon, let radius):
            return [
                "key": Environment.API.apiKey,
                "type": type,
                "keyword": keyword,
                "location": "\(lat),\(lon)",
                "radius": radius,
            ]
        case .calculateDistances(let origins, let destinations):
            return [
                "key": Environment.API.apiKey,
                "origins": origins,
                "destinations": destinations,
                "mode": "driving",
                "units": "metric"
            ]
        case .getDetailPlace(let place_id):
            return [
                "key": Environment.API.apiKey,
                "place_id": place_id
            ]
        case .getSearch(let query):
            return [
                "key": Environment.API.apiKey,
                "query": query,
            ]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getPlaceByCategory,
             .calculateDistances,
             .getDetailPlace,
             .getSearch
            :
            return ["Content-Type": "application/json"]
        }
    }
}
