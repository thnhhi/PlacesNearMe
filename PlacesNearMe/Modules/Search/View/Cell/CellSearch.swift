//
//  CellSearch.swift
//  PlacesNearMe
//
//  Created by VTVH on 31/7/25.
//

import UIKit

class CellSearch: UITableViewCell {

    @IBOutlet weak var lblNamePlace: UILabel!
    @IBOutlet weak var lblAddressPlace: UILabel!
    @IBOutlet weak var lblDistancePlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(name: String, address: String, distance: String) {
        lblNamePlace.text = name
        lblAddressPlace.text = address
        lblDistancePlace.text = distance
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
