//
//  CellPhotoDetailPlace.swift
//  PlacesNearMe
//
//  Created by VTVH on 30/7/25.
//

import UIKit
import Kingfisher

class CellPhotoDetailPlace: UICollectionViewCell {
    
    @IBOutlet weak var imgDetailPlace: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgDetailPlace.layer.cornerRadius = 10
        imgDetailPlace.clipsToBounds = true
    }
    
    func configure(with photo: Photos) {
        let api = Environment.API.Api_Get_Photo_Detail_Place
        let key = Environment.API.apiKey
        let maxwidth = AppConfig.maxwidth_Api_Get_Photo_Detail_Place
        let maxheight = AppConfig.maxheight_Api_Get_Photo_Detail_Place
        let photoreference = photo.photo_reference ?? ""
        
        let urlStr = "\(api)?maxwidth=\(maxwidth)&maxheight=\(maxheight)&photoreference=\(photoreference)&key=\(key)"
        if let url = URL(string: urlStr) {
            imgDetailPlace.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
}
