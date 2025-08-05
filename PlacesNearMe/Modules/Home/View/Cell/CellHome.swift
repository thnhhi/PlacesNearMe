//
//  CellHome.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

import UIKit

class CellHome: UICollectionViewCell {

    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorder()
    }
    
    private func setupBorder() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
