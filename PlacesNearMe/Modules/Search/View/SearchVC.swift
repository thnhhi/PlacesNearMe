//
//  SearchVC.swift
//  PlacesNearMe
//
//  Created by VTVH on 31/7/25.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func showSearch(_ results: [ResultsSearch], isEmpty: Bool)
    func showError(_ message: String)
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tbvSearch: UITableView!
    @IBOutlet weak var lblEmptyMessage: UILabel!
    
    var presenter: SearchPresenterProtocol!
    var resultsSearch: [ResultsSearch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupDismissKeyboardGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(shouldHide: true)
        removeBackButtonText()
    }
    
    private func setupTableView() {
        tbvSearch.register(UINib(nibName: "CellSearch", bundle: nil), forCellReuseIdentifier: "CellSearch")
        tbvSearch.delegate = self
        tbvSearch.dataSource = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = AppConfig.placeholder_searchbar_view_search
        searchBar.searchBarStyle = .minimal // ẩn viền
        searchBar.tintColor = .systemBlue
        searchBar.barTintColor = .white
        searchBar.backgroundColor = .clear
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Cho phép tap vào cell/tableView
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellSearch") as? CellSearch else {
            return UITableViewCell()
        }
        
        let item = resultsSearch[indexPath.row]
        cell.configure(name: item.name ?? "",
                       address: item.formatted_address ?? "",
                       distance: item.distanceText ?? "")
        return cell
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let place_id = resultsSearch[indexPath.row].place_id else { return }
        presenter.pushToDetailPlace(place_id: place_id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Ẩn bàn phím
            searchBar.resignFirstResponder()
            
            // Dọn kết quả
            self.resultsSearch = []
            self.tbvSearch.reloadData()
            self.tbvSearch.isHidden = true
            
            // Nếu có label trống (lblEmptyMessage), cũng ẩn nó
             self.lblEmptyMessage.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else {
            // Hiện alert nếu người dùng chưa nhập gì
            showAlert(message: "Vui lòng nhập nội dung tìm kiếm.")
            return
        }
        
        guard let coordinate = AppLocation.shared.currentCoordinate else {
            print("Không thể lấy vị trí người dùng.")
            return
        }
        
        presenter.fetchSearch(query: text,
                              lat: coordinate.latitude,
                              lon: coordinate.longitude)
    }
}

extension SearchVC: SearchViewProtocol {
    func showSearch(_ results: [ResultsSearch], isEmpty: Bool) {
        self.resultsSearch = results
        DispatchQueue.main.async {
            self.lblEmptyMessage.isHidden = !isEmpty
            self.tbvSearch.isHidden = isEmpty
            self.tbvSearch.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
}
