//
//  FindingVC.swift
//  PlacesNearMe
//
//  Created by VTVH on 21/7/25.
//

import UIKit

protocol FindingViewProtocol: AnyObject {
    func showNavigationTitle(_ title: String)
    func showPlaceByCategory(_ results: [Results], isEmpty: Bool)
    func showError(_ message: String)
}

class FindingVC: UIViewController {
    
    @IBOutlet weak var tbvFinding: UITableView!
    @IBOutlet weak var lblEmptyMessage: UILabel!
    
    var presenter: FindingPresenterProtocol!
    var resultsFinding: [Results] = []
    var titleNavigationBar: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: titleNavigationBar, backgroundColor: .white, titleColor: .black, tintColor: .black, hideBackTitle: true, shouldHide: false)
    }
    
    private func setupTableView() {
        tbvFinding.register(UINib(nibName: "CellFinding", bundle: nil), forCellReuseIdentifier: "CellFinding")
        tbvFinding.delegate = self
        tbvFinding.dataSource = self
    }
}

extension FindingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsFinding.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellFinding") as? CellFinding else {
            return UITableViewCell()
        }
        
        let item = resultsFinding[indexPath.row]
        cell.configure(name: item.name ?? "",
                       address: item.vicinity ?? "",
                       distance: item.distanceText ?? "")
        return cell
    }
}

extension FindingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let place_id = resultsFinding[indexPath.row].place_id else { return }
        presenter.pushToDetailPlace(place_id: place_id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension FindingVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
//        presenter.didScrollToBottom(currentOffset: position, contentHeight: contentHeight, frameHeight: frameHeight)
    }
}

extension FindingVC: FindingViewProtocol {
    func showNavigationTitle(_ title: String) {
        self.titleNavigationBar = title
    }
    
    func showPlaceByCategory(_ results: [Results], isEmpty: Bool) {
        self.resultsFinding = results
        DispatchQueue.main.async {
            self.lblEmptyMessage.isHidden = !isEmpty
            self.tbvFinding.isHidden = isEmpty
            self.tbvFinding.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
}
