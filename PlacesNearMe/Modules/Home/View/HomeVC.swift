//
//  HomeVC.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

import UIKit
import CoreLocation

protocol HomeViewProtocol: AnyObject {
    func reloadData()
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var clsViewHome: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnRadius: UIButton!
    
    var presenter: HomePresenterProtocol!
    private var sliderLabel: UILabel?
    private var selectedRadius: Int = AppConfig.defaultRadius
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        setupButton()
        presenter.viewDidLoad()
    }
    
    @IBAction func actionChangeRadius(_ sender: Any) {
        showRadiusSliderPopup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(shouldHide: true)
        removeBackButtonText()
    }
    
    private func setupCollectionView() {
        clsViewHome.register(UINib(nibName: "CellHome", bundle: nil), forCellWithReuseIdentifier: "CellHome")
        clsViewHome.dataSource = self
        clsViewHome.delegate = self
        clsViewHome.contentInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = AppConfig.placeholder_searchbar_view_home
        searchBar.searchBarStyle = .minimal // ẩn viền
        searchBar.tintColor = .systemBlue
        searchBar.barTintColor = .white
        searchBar.backgroundColor = .clear
    }
    
    private func setupButton() {
        // Giá trị bán kính mặc định
        selectedRadius = AppConfig.defaultRadius
        
        let radiusText = Double(selectedRadius).formattedDistance
        btnRadius.setTitle("🔍 \(radiusText)", for: .normal)
    }
    
    private func showRadiusSliderPopup() {
        let alert = UIAlertController(title: "Chọn bán kính", message: "\n\n\n\n", preferredStyle: .alert)
        
        let width: CGFloat = 250
        
        // UILabel hiển thị giá trị
        let label = UILabel(frame: CGRect(x: 10, y: 55, width: width, height: 20))
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.text = "\(AppConfig.defaultRadius) mét"
        self.sliderLabel = label
        
        // UISlider chọn bán kính
        let slider = UISlider(frame: CGRect(x: 10, y: 100, width: width, height: 20))
        slider.minimumValue = Float(AppConfig.minRadius)
        slider.maximumValue = Float(AppConfig.maxRadius)
        slider.value = Float(AppConfig.defaultRadius)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        // Thêm vào view của UIAlertController
        alert.view.addSubview(label)
        alert.view.addSubview(slider)
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let selectedRadius = Int(slider.value)
            self.updateSearchRadius(selectedRadius)
        }))
        
        self.present(alert, animated: true)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let value = Double(sender.value) // đảm bảo làm tròn về đơn vị mét
        sliderLabel?.text = value.formattedDistance
    }
    
    private func updateSearchRadius(_ radius: Int) {
        print("✅ Radius đã chọn: \(radius) mét")
        
        // Gán lại vào biến dùng cho search (ví dụ nếu bạn có property)
        self.selectedRadius = radius
        
        // Cập nhật UI (button bạn đã tạo trên storyboard)
        let radiusText = Double(radius).formattedDistance
        self.btnRadius.setTitle("🔍 \(radiusText)", for: .normal)
    }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryPlace = presenter.categoryPlace(at: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHome", for: indexPath) as! CellHome
        cell.imgPlace.image = UIImage(named: "\(categoryPlace.img)")
        cell.lblTitle.text = "\(categoryPlace.nameVi)"
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryPlace = presenter.categoryPlace(at: indexPath.row)
        guard let coordinate = AppLocation.shared.currentCoordinate else {
            print("Không thể lấy vị trí người dùng.")
            return
        }
        presenter.didTapFind(nameCategory: categoryPlace.nameVi,
                             type: categoryPlace.type,
                             keyword: categoryPlace.keyword,
                             lat: coordinate.latitude,
                             lon: coordinate.longitude,
                             radius: selectedRadius)
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 30
        return CGSize(width: screenWidth/5, height: (screenWidth/5)*1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeVC: HomeViewProtocol {
    func reloadData() {
        clsViewHome.reloadData()
    }
}
