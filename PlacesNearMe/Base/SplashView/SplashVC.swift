//
//  SplashVC.swift
//  PlacesNearMe
//
//  Created by VTVH on 21/7/25.
//

import UIKit

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
    }
    
    private func setupLocation() {
        AppLocation.shared.requestCurrentLocation(from: self) { coordinate in
            if let coordinate = coordinate {
                print("Đã lấy vị trí: \(coordinate.latitude), \(coordinate.longitude)")
                // Sau khi lấy xong vị trí, chuyển sang màn hình chính
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.moveToMain()
                }
            } else {
                print("Người dùng từ chối cấp quyền vị trí.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.moveToMain()
                }
            }
        }
    }
    
    private func moveToMain() {
        let tabBarController = TabBarController()
        let nav = UINavigationController(rootViewController: tabBarController)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
