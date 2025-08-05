//
//  SearchRouter.swift
//  PlacesNearMe
//
//  Created by VTVH on 31/7/25.
//

import UIKit

protocol SearchRouterProtocol {
    func pushToDetailPlace(from view: SearchViewProtocol, place_id: String)
}

class SearchRouter: SearchRouterProtocol {
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "SearchVC", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else {
            fatalError("Could not instantiate SearchVC from storyboard")
        }
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToDetailPlace(from view: SearchViewProtocol, place_id: String) {
        let detailPlaceVC = DetailPlaceRouter.createModule(place_id: place_id)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailPlaceVC, animated: true)
        }
    }
}
