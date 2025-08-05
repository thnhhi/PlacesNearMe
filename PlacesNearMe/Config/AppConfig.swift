//
//  AppConfig.swift
//  PlacesNearMe
//
//  Created by VTVH on 23/7/25.
//

struct AppConfig {
    // Số lượng kết quả trả về trong 1 lần gọi API
    static var resultLimit: Int = 50
    
    // Bán kính tìm kiếm mặc định (mét)
    static var defaultRadius: Int = 500
    
    // Bán kính tối thiểu và tối đa (mét)
    static let minRadius: Int = 500
    static let maxRadius: Int = 5000
    
    //max width,height lấy ảnh từ google place
    static let maxwidth_Api_Get_Photo_Detail_Place: Int = 1000
    static let maxheight_Api_Get_Photo_Detail_Place: Int = 1000
    
    //placeholder SearchBar
    static let placeholder_searchbar_view_home: String = "Tìm kiếm danh mục"
    static let placeholder_searchbar_view_search: String = "Tìm kiếm địa điểm"
}
