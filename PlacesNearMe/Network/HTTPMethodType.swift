//
//  HTTPMethodType.swift
//  PlacesNearMe
//
//  Created by VTVH on 22/7/25.
//

import Alamofire

enum HTTPMethodType {
    case get
    case post
    case put
    case delete
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        }
    }
}
