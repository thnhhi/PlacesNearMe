//
//  HomePresenter.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

protocol HomePresenterProtocol {
    func viewDidLoad()
    func numberOfRows() -> Int
    func categoryPlace(at index: Int) -> CategoryPlace
    func search(text: String)
    func didTapFind(nameCategory: String, type: String, keyword: String, lat: Double, lon: Double , radius: Int)
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    private var arrCategoryPlace: [CategoryPlace] = []              // Mảng gốc
    private var filteredCategoryPlace: [CategoryPlace] = []         // Mảng hiển thị sau lọc
    
    func viewDidLoad() {
        interactor?.getCategoryPlaces()
    }
    
    func numberOfRows() -> Int {
        return filteredCategoryPlace.count
    }
    
    func categoryPlace(at index: Int) -> CategoryPlace {
        return filteredCategoryPlace[index]
    }
    
    func search(text: String) {
        let keyword = text.lowercased().removingAccents()
        
        if keyword.isEmpty {
            filteredCategoryPlace = arrCategoryPlace
        } else {
            filteredCategoryPlace = arrCategoryPlace.filter {
                let title = $0.nameVi.lowercased().removingAccents()
                return title.contains(keyword)
            }
        }
        view?.reloadData()
    }
    
    func didTapFind(nameCategory: String, type: String, keyword: String, lat: Double, lon: Double , radius: Int) {
        router?.pushToFinding(from: view!, nameCategory: nameCategory, type: type, keyword: keyword, lat: lat, lon: lon , radius: radius)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func didGetCategoryPlaces(_ categoryPlace: [CategoryPlace]) {
        self.arrCategoryPlace = categoryPlace
        self.filteredCategoryPlace = categoryPlace // Gán luôn dữ liệu lọc ban đầu
        view?.reloadData()
    }
}
