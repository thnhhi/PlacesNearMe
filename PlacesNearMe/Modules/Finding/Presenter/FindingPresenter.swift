//
//  FindingPresenter.swift
//  PlacesNearMe
//
//  Created by VTVH on 21/7/25.
//

import Foundation

protocol FindingPresenterProtocol {
    func viewDidLoad()
    func pushToDetailPlace(place_id: String)
}

class FindingPresenter: FindingPresenterProtocol {
    weak var view: FindingViewProtocol?
    var interactor: FindingInteractorInputProtocol?
    var router: FindingRouter?
    
    private var results: [Results] = []
    
    var nameCategory: String = ""
    var type: String = ""
    var keyword: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
    var radius: Int = 0
    
    func viewDidLoad() {
        interactor?.fetchPlaceAndDistanceByCategory(type: type, keyword: keyword, lat: lat, lon: lon, radius: radius)
        view?.showNavigationTitle(nameCategory)
    }
    
    func pushToDetailPlace(place_id: String) {
        router?.pushToDetailPlace(from: view!, place_id: place_id)
    }
}

extension FindingPresenter: FindingInteractorOutputProtocol {
    func didFetchPlaceAndDistanceByCategory(_ results: [Results]) {
        self.results = results
        let isEmpty = results.isEmpty
        view?.showPlaceByCategory(results, isEmpty: isEmpty)
    }
    
    func didFailToPlaceAndDistanceByCategory(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
}
