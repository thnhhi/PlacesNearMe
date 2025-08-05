//
//  DetailPlaceInteractor.swift
//  PlacesNearMe
//
//  Created by VTVH on 30/7/25.
//

protocol DetailPlaceInteractorInputProtocol {
    func fetchDetailPlace(place_id: String)
}

protocol DetailPlaceInteractorOutputProtocol: AnyObject {
    func didFetchDetailPlace(_ results: ResultDetailPlace)
    func didFailToFetchDetailPlace(_ error: Error)
}

class DetailPlaceInteractor: DetailPlaceInteractorInputProtocol {
    
    weak var presenter: DetailPlaceInteractorOutputProtocol?
    
    func fetchDetailPlace(place_id: String) {
        APIManager.shared.request(endpoint: .getDetailPlace(place_id: place_id), responseType: DetailPlaceModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                if let results = value.result {
                    self.presenter?.didFetchDetailPlace(results)
                }
            case .failure(let err):
                self.presenter?.didFailToFetchDetailPlace(err)
            }
        }
    }
}
