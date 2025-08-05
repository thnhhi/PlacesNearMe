//
//  PlaceByCategoryModel.swift
//  PlacesNearMe
//
//  Created by VTVH on 21/7/25.
//

import ObjectMapper

class PlaceByCategory: Mappable {
    var html_attributions: [String]?
    var next_page_token: String?
    var results: [Results]?
    var status: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        html_attributions <- map["html_attributions"]
        next_page_token <- map["next_page_token"]
        results <- map["results"]
        status <- map["status"]
    }
}

class Results: Mappable {
    var business_status: String?
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
    var scope: String?
    var types: [String]?
    var user_ratings_total: Int?
    var vicinity: String?
    
    var distanceText: String?
    var distanceValue: Int?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        business_status <- map["business_status"]
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
        scope <- map["scope"]
        types <- map["types"]
        user_ratings_total <- map["user_ratings_total"]
        vicinity <- map["vicinity"]
    }
}

class Geometry: Mappable {
    var location: Location?
    var viewport: Viewport?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        location <- map["location"]
        viewport <- map["viewport"]
    }
}

class Location: Mappable {
    var lat: Double?
    var lng: Double?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class Viewport: Mappable {
    var northeast: Northeast?
    var southwest: Southwest?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        northeast <- map["northeast"]
        southwest <- map["southwest"]
    }
}

class Northeast: Mappable {
    var lat: Double?
    var lng: Double?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class Southwest: Mappable {
    var lat: Double?
    var lng: Double?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class Opening_hours: Mappable {
    var open_now: Bool?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        open_now <- map["open_now"]
    }
}

class Photos: Mappable {
    var height: Int?
    var html_attributions: [String]?
    var photo_reference: String?
    var width: Int?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        height <- map["height"]
        html_attributions <- map["html_attributions"]
        photo_reference <- map["photo_reference"]
        width <- map["width"]
    }
}

class Plus_code: Mappable {
    var compound_code: String?
    var global_code: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        compound_code <- map["compound_code"]
        global_code <- map["global_code"]
    }
}
