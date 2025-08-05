//
//  SearchInteractor.swift
//  PlacesNearMe
//
//  Created by VTVH on 31/7/25.
//

protocol SearchInteractorInputProtocol {
    func fetchSearch(query: String, lat: Double, lon: Double)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didFetchSearch(_ result: [ResultsSearch])
    func didFailToFetchSearch(_ error: Error)
}

class SearchInteractor: SearchInteractorInputProtocol {
    
    weak var presenter: SearchInteractorOutputProtocol?
    
    func fetchSearch(query: String, lat: Double, lon: Double) {
        APIManager.shared.request(endpoint: .getSearch(query: query), responseType: Search.self, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                let results = value.results ?? []
                let destinations = results.compactMap { "\($0.geometry?.location?.lat ?? 0),\($0.geometry?.location?.lng ?? 0)" }.joined(separator: "|")
                let origin = "\(lat),\(lon)"

                // Gọi tiếp API tính khoảng cách
                APIManager.shared.request(endpoint: .calculateDistances(origins: origin, destinations: destinations), responseType: DistanceModel.self) { distanceResult in
                    switch distanceResult {
                    case .success(let distanceData):
                        let elements = distanceData.rows?.first?.elements ?? []
                        
                        // Gán khoảng cách text + value cho từng địa điểm
                        for (index, distance) in elements.enumerated() {
                            results[index].distanceText = distance.distance?.text
                            results[index].distanceValue = distance.distance?.value // để sort
                        }
                        
                        // ✅ Sắp xếp tăng dần theo khoảng cách value
                        let sortedResults = results.sorted {
                            ($0.distanceValue ?? Int.max) < ($1.distanceValue ?? Int.max)
                        }
                        
                        self.presenter?.didFetchSearch(sortedResults)
                    case .failure(let err):
                        self.presenter?.didFailToFetchSearch(err)
                    }
                }
            case .failure(let err):
                self.presenter?.didFailToFetchSearch(err)
            }
        })
    }
}
