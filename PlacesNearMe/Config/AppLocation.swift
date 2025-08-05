//
//  AppLocation.swift
//  PlacesNearMe
//
//  Created by VTVH on 23/7/25.
//

import CoreLocation
import UIKit

final class AppLocation: NSObject {
    static let shared = AppLocation()
    
    private let locationManager = CLLocationManager()
    private var completion: ((CLLocationCoordinate2D?) -> Void)?
    
    // ✅ Vị trí đã lấy gần nhất (dùng chung toàn app)
    private(set) var currentCoordinate: CLLocationCoordinate2D?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestCurrentLocation(from viewController: UIViewController, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        self.completion = completion
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            showPermissionAlert(from: viewController)
            completion(nil)
        @unknown default:
            completion(nil)
        }
    }
    
    private func showPermissionAlert(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Cần quyền vị trí",
            message: "Vui lòng bật quyền truy cập vị trí trong Cài đặt để tìm các địa điểm gần bạn.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cài đặt", style: .default, handler: { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL)
        }))
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel))
        viewController.present(alert, animated: true)
    }
}

extension AppLocation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            currentCoordinate = coordinate // ✅ Lưu lại vị trí hiện tại
            completion?(coordinate)
        } else {
            completion?(nil)
        }
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil)
        completion = nil
    }
}
