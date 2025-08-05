//
//  UIView+Extension.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

import UIKit

extension UIViewController {
    //Custom Navigation Bar dễ tái sử dụng
    func setupNavigationBar(title: String = "",
                            backgroundColor: UIColor = .white,
                            titleColor: UIColor = .black,
                            tintColor: UIColor = .black,
                            hideBackTitle: Bool = true,
                            shouldHide: Bool = false) {
        
        navigationController?.setNavigationBarHidden(shouldHide, animated: false)
        guard !shouldHide else { return }

        navigationItem.title = title

        if hideBackTitle {
            let backBarButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backBarButton
        }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = tintColor
    }
    
    func removeBackButtonText() {
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    func showAlert(title: String = "Thông báo",
                   message: String,
                   okTitle: String = "OK",
                   cancelTitle: String = "Huỷ",
                   showCancel: Bool = false,
                   shouldShow: Bool = true,
                   onOK: (() -> Void)? = nil,
                   onCancel: (() -> Void)? = nil) {
        
        guard shouldShow else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // Title style: centered
        let titleStyle = NSMutableParagraphStyle()
        titleStyle.alignment = .center
        
        let titleAttr: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .paragraphStyle: titleStyle,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        alert.setValue(NSAttributedString(string: "\(title)\n", attributes: titleAttr), forKey: "attributedTitle")
        
        // Message style: centered
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.alignment = .center
        
        let messageAttr: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .paragraphStyle: messageStyle,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        alert.setValue(NSAttributedString(string: message, attributes: messageAttr), forKey: "attributedMessage")
        
        // Background color
        if let bg = alert.view.subviews.first?.subviews.first?.subviews.first {
            bg.backgroundColor = .black
        }
        alert.view.tintColor = .systemYellow
        
        // OK button
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in onOK?() }
        alert.addAction(okAction)
        
        // Optional cancel
        if showCancel {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in onCancel?() }
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true)
    }
}
