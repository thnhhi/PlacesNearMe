//
//  DetailPlaceVC.swift
//  PlacesNearMe
//
//  Created by VTVH on 30/7/25.
//

import UIKit

protocol DetailPlaceViewProtocol: AnyObject {
    func showDetailPlace(_ results: ResultDetailPlace, isEmpty: Bool)
    func showError(_ message: String)
}

class DetailPlaceVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCategoryPlace: UILabel!
    @IBOutlet weak var lblOpeningHour: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblOpeningHour_1: UILabel!
    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var clsViewPhotoDetailPlace: UICollectionView!
    @IBOutlet weak var heightConstraintClsViewPhotoDetailPlace: NSLayoutConstraint!
    
    var presenter: DetailPlacePresenterProtocol!
    private var latitude: Double?
    private var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupButton()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: "Chi tiết", backgroundColor: .white, titleColor: .black, tintColor: .black, hideBackTitle: true, shouldHide: false)
    }
    
    @IBAction func actionDirectionToGoogleMaps(_ sender: Any) {
        handleDirectionToGoogleMaps()
    }
    
    private func setupCollectionView() {
        clsViewPhotoDetailPlace.register(UINib(nibName: "CellPhotoDetailPlace", bundle: nil), forCellWithReuseIdentifier: "CellPhotoDetailPlace")
        clsViewPhotoDetailPlace.dataSource = self
        clsViewPhotoDetailPlace.delegate = self
        clsViewPhotoDetailPlace.isPagingEnabled = true
        clsViewPhotoDetailPlace.showsHorizontalScrollIndicator = false
    }
    
    private func setupButton() {
        btnDirection.layer.cornerRadius = 20
        btnDirection.layer.shadowColor = UIColor.black.cgColor
        btnDirection.layer.shadowOpacity = 0.2
        btnDirection.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnDirection.layer.shadowRadius = 4
    }
    
    private func handleDirectionToGoogleMaps() {
        guard let lat = latitude, let lng = longitude else {
            print("Không có tọa độ để điều hướng")
            return
        }
        
        // Ưu tiên mở Google Maps app
        let googleMapsAppURL = URL(string: "comgooglemaps://?daddr=\(lat),\(lng)&directionsmode=driving")!
        let googleMapsWebURL = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(lng)&travelmode=driving")!
        
        if UIApplication.shared.canOpenURL(googleMapsAppURL) {
            UIApplication.shared.open(googleMapsAppURL)
        } else {
            // Nếu không có app, fallback về web
            UIApplication.shared.open(googleMapsWebURL)
        }
    }
}

extension DetailPlaceVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellPhotoDetailPlace", for: indexPath) as! CellPhotoDetailPlace
        let photo = presenter.photo(at: indexPath.row)
        cell.configure(with: photo)
        return cell
    }
}

extension DetailPlaceVC: UICollectionViewDelegate {
    
}

extension DetailPlaceVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20 // Trừ 10 mỗi bên
        let height = collectionView.bounds.height - 20 // Trừ 10 mỗi bên
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20 // Để tránh dính nhau khi scroll paging
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DetailPlaceVC: DetailPlaceViewProtocol {
    func showDetailPlace(_ results: ResultDetailPlace, isEmpty: Bool) {
        self.latitude = results.geometry?.location?.lat
        self.longitude = results.geometry?.location?.lng
        
        if results.photos == nil {
            clsViewPhotoDetailPlace.isHidden = true
            heightConstraintClsViewPhotoDetailPlace.constant = 0
        } else {
            clsViewPhotoDetailPlace.isHidden = false
            heightConstraintClsViewPhotoDetailPlace.constant = 400
            clsViewPhotoDetailPlace.reloadData()
        }
        
        lblName.text = results.name ?? "Không có tên"
        lblRating.text = results.rating != nil ? "⭐️ \(results.rating!)" : "Chưa có đánh giá"
        lblCategoryPlace.text = results.types?.first?.replacingOccurrences(of: "_", with: " ").capitalized ?? "Không rõ loại"
        
        
        let openingText: String
        if let openNow = results.current_opening_hours?.open_now {
            openingText = openNow ? "Đang mở cửa" : "Đang đóng cửa"
        } else {
            openingText = "Không có thông tin giờ mở cửa"
        }
        lblOpeningHour.text = openingText
        lblOpeningHour_1.text = openingText
        
        lblAddress.text = results.formatted_address ?? "Không có địa chỉ"
        
        if isEmpty {
            // Có thể show alert hoặc view báo "Không có dữ liệu"
            print("Không tìm thấy thông tin chi tiết")
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
}
