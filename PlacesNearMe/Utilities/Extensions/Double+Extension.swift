//
//  Double+Extension.swift
//  PlacesNearMe
//
//  Created by VTVH on 22/7/25.
//

extension Double {
    var formattedDistance: String {
        if self < 1000 {
            return String(format: "%.0f m", self)
        } else {
            let km = self / 1000
            return String(format: "%.2f km", km).replacingOccurrences(of: ".", with: ",")
        }
    }
}
