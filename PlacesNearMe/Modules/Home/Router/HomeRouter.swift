//
//  HomeRouter.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

import UIKit

protocol HomeRouterProtocol {
    func pushToFinding(from view: HomeViewProtocol, nameCategory: String, type: String, keyword: String, lat: Double, lon: Double , radius: Int)
}

class HomeRouter: HomeRouterProtocol {
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
            fatalError("Could not instantiate HomeVC from storyboard")
        }
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToFinding(from view: HomeViewProtocol, nameCategory: String, type: String, keyword: String, lat: Double, lon: Double , radius: Int) {
        let findingVC = FindingRouter.createModule(nameCategory: nameCategory, type: type, keyword: keyword, lat: lat, lon: lon, radius: radius)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(findingVC, animated: true)
        }
    }
}
