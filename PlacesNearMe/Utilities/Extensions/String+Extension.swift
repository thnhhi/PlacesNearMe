//
//  String+Extension.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

extension String {
    func formattedDistance() -> String? {
        guard let distance = Double(self) else { return nil }
        
        if distance < 1000 {
            return String(format: "%.0f m", distance)
        } else {
            return String(format: "%.1f km", distance / 1000)
        }
    }
    
    func removingAccents() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
            .replacingOccurrences(of: "đ", with: "d")
            .replacingOccurrences(of: "Đ", with: "D")
    }
}
