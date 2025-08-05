//
//  FindingInteractor.swift
//  PlacesNearMe
//
//  Created by VTVH on 21/7/25.
//

protocol FindingInteractorInputProtocol {
    func fetchPlaceAndDistanceByCategory(type: String, keyword: String, lat: Double, lon: Double, radius: Int)
}

protocol FindingInteractorOutputProtocol: AnyObject {
    func didFetchPlaceAndDistanceByCategory(_ results: [Results])
    func didFailToPlaceAndDistanceByCategory(_ error: Error)
}

class FindingInteractor: FindingInteractorInputProtocol {

    weak var presenter: FindingInteractorOutputProtocol?
    
    func fetchPlaceAndDistanceByCategory(type: String, keyword: String, lat: Double, lon: Double, radius: Int) {
        APIManager.shared.request(endpoint: .getPlaceByCategory(type: type, keyword: keyword, lat: lat, lon: lon, radius: radius), responseType: PlaceByCategory.self) { [weak self] result in
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
                        
                        self.presenter?.didFetchPlaceAndDistanceByCategory(sortedResults)
                    case .failure(let err):
                        self.presenter?.didFailToPlaceAndDistanceByCategory(err)
                    }
                }
            case .failure(let err):
                self.presenter?.didFailToPlaceAndDistanceByCategory(err)
            }
        }
    }
}
