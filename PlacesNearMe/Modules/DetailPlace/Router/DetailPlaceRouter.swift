//
//  DetailPlaceRouter.swift
//  PlacesNearMe
//
//  Created by VTVH on 30/7/25.
//

import UIKit

protocol DetailPlaceRouterProtocol {
    
}

class DetailPlaceRouter: DetailPlaceRouterProtocol {
    static func createModule(place_id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailPlaceVC", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "DetailPlaceVC") as? DetailPlaceVC else {
            fatalError("Could not instantiate DetailPlaceVC from storyboard")
        }
        
        let presenter = DetailPlacePresenter()
        let interactor = DetailPlaceInteractor()
        let router = DetailPlaceRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        presenter.place_id = place_id
        
        return view
    }
}
