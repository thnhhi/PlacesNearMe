//
//  DetailPlacePresenter.swift
//  PlacesNearMe
//
//  Created by VTVH on 30/7/25.
//

import Foundation

protocol DetailPlacePresenterProtocol {
    func viewDidLoad()
    func numberOfRows() -> Int
    func photo(at index: Int) -> Photos
}

class DetailPlacePresenter: DetailPlacePresenterProtocol {
    weak var view: DetailPlaceViewProtocol?
    var interactor: DetailPlaceInteractorInputProtocol?
    var router: DetailPlaceRouter?
    
    var place_id: String = ""
    private var photoDetailPlace: [Photos] = []
    
    func viewDidLoad() {
        interactor?.fetchDetailPlace(place_id: place_id)
    }
    
    func numberOfRows() -> Int {
        return photoDetailPlace.count
    }
    
    func photo(at index: Int) -> Photos {
        return photoDetailPlace[index]
    }
}

extension DetailPlacePresenter: DetailPlaceInteractorOutputProtocol {
    func didFetchDetailPlace(_ results: ResultDetailPlace) {
        self.photoDetailPlace = results.photos ?? []
        
        let isEmpty = results.name == ""
        view?.showDetailPlace(results, isEmpty: isEmpty)
    }
    
    func didFailToFetchDetailPlace(_ error: any Error) {
        view?.showError(error.localizedDescription)
    }
}
