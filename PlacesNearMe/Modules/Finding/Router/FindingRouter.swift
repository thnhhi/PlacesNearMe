//
//  FindingRouter.swift
//  PlacesNearMe
//
//  Created by VTVH on 21/7/25.
//

import UIKit

protocol FindingRouterProtocol {
    func pushToDetailPlace(from view: FindingViewProtocol, place_id: String)
}

class FindingRouter: FindingRouterProtocol {
    static func createModule(nameCategory: String, type: String, keyword: String, lat: Double, lon: Double, radius: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "FindingVC", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "FindingVC") as? FindingVC else {
            fatalError("Could not instantiate FindingVC from storyboard")
        }
        
        let presenter = FindingPresenter()
        let interactor = FindingInteractor()
        let router = FindingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        presenter.nameCategory = nameCategory
        presenter.type = type
        presenter.keyword = keyword
        presenter.lat = lat
        presenter.lon = lon
        presenter.radius = radius
        
        return view
    }
    
    func pushToDetailPlace(from view: FindingViewProtocol, place_id: String) {
        let detailPlaceVC = DetailPlaceRouter.createModule(place_id: place_id)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailPlaceVC, animated: true)
        }
    }
}
