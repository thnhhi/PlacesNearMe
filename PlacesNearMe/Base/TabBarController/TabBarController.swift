//
//  TabBarController.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarShadow()
        setupTabBarAppearance()
        delegate = self
    }
    
    private func setupTabBar() {
        let homeVC = HomeRouter.createModule()
        homeVC.tabBarItem = UITabBarItem(title: "Trang Chủ",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        let searchVC = SearchRouter.createModule()
        searchVC.tabBarItem = UITabBarItem(title: "Tìm Kiếm",
                                         image: UIImage(systemName: "magnifyingglass.circle"),
                                         selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        viewControllers = [homeVC, searchVC]
    }
    
    private func setupTabBarShadow() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.masksToBounds = false
        tabBar.backgroundImage = UIImage() // Xóa line mặc định
        tabBar.shadowImage = UIImage()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        // Đổi màu selected và unselected
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.gray]

        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    // Optional: Xử lý khi chuyển tab (nếu muốn)
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Đã chọn tab: \(viewController.tabBarItem.title ?? "Unknown")")
    }
}
