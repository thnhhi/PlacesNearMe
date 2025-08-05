//
//  APIManager.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

import Foundation
import Alamofire
import ObjectMapper

class APIManager {
    static let shared = APIManager()
    private let baseURL = Environment.API.baseURL
    
    func request<T: Mappable>(endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint.path) else {
            print("❌ Invalid URL: \(baseURL + endpoint.path)")
            completion(.failure(.invalidURL))
            return
        }
        
        let method = endpoint.method.method
        let headers = HTTPHeaders(endpoint.headers ?? [:])
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        let parameters = endpoint.parameters // [String: Any]?
        
        print("🚀 Request Start")
        print("🔹 URL: \(url)")
        print("🔹 Method: \(method)")
        print("🔹 Headers: \(headers)")
        print("🔹 Parameters: \(parameters ?? [:])")
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .responseJSON { response in
            print("📥 Response Received")
            switch response.result {
            case .success(let value):
                if let mapped = Mapper<T>().map(JSONObject: value) {
                    if let jsonDict = (mapped.toJSON() as? [String: Any]),
                       let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("✅ Mapped JSON:\n\(jsonString)")
                    } else {
                        print("⚠️ Could not convert mapped object to JSON")
                    }
                    completion(.success(mapped))
                } else {
                    print("❌ Mapping error with value: \(value)")
                    completion(.failure(.mappingFailed))
                }
            case .failure(let error):
                print("❌ Network error: \(error)")
                completion(.failure(.networkError(error)))
            }
        }
    }
}
