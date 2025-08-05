//
//  SearchPresenter.swift
//  PlacesNearMe
//
//  Created by VTVH on 31/7/25.
//

protocol SearchPresenterProtocol {
    func fetchSearch(query: String, lat: Double, lon: Double)
    func pushToDetailPlace(place_id: String)
}

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    func fetchSearch(query: String, lat: Double, lon: Double) {
        interactor?.fetchSearch(query: query, lat: lat, lon: lon)
    }
    
    func pushToDetailPlace(place_id: String) {
        router?.pushToDetailPlace(from: view!, place_id: place_id)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func didFetchSearch(_ results: [ResultsSearch]) {
        let isEmpty = results.isEmpty
        view?.showSearch(results, isEmpty: isEmpty)
    }
    
    func didFailToFetchSearch(_ error: any Error) {
        view?.showError(error.localizedDescription)
    }
}
