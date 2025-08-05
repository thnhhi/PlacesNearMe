//
//  SearchModel.swift
//  PlacesNearMe
//
//  Created by VTVH on 31/7/25.
//

import ObjectMapper

class Search: Mappable {
    var html_attributions: [String]?
    var next_page_token: String?
    var results: [ResultsSearch]?
    var status: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        html_attributions <- map["html_attributions"]
        next_page_token <- map["next_page_token"]
        results <- map["results"]
        status <- map["status"]
    }
}

class ResultsSearch: Mappable {
    var business_status: String?
    var formatted_address: String?
    var geometry: Geometry?
    var icon: String?
    var icon_background_color: String?
    var icon_mask_base_uri: String?
    var name: String?
    var opening_hours: Opening_hours?
    var photos: [Photos]?
    var place_id: String?
    var plus_code: Plus_code?
    var price_level: Int?
    var rating: Double?
    var reference: String?
    var types: [String]?
    var user_ratings_total: Int?
    
    var distanceText: String?
    var distanceValue: Int?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        business_status <- map["business_status"]
        formatted_address <- map["formatted_address"]
        geometry <- map["geometry"]
        icon <- map["icon"]
        icon_background_color <- map["icon_background_color"]
        icon_mask_base_uri <- map["icon_mask_base_uri"]
        name <- map["name"]
        opening_hours <- map["opening_hours"]
        photos <- map["photos"]
        place_id <- map["place_id"]
        plus_code <- map["plus_code"]
        price_level <- map["price_level"]
        rating <- map["rating"]
        reference <- map["reference"]
        types <- map["types"]
        user_ratings_total <- map["user_ratings_total"]
    }
}
