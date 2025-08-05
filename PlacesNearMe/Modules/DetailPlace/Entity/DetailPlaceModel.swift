//
//  DetailPlaceModel.swift
//  PlacesNearMe
//
//  Created by VTVH on 30/7/25.
//

import ObjectMapper

class DetailPlaceModel: Mappable {
    var html_attributions: [String]?
    var result: ResultDetailPlace?
    var status: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        html_attributions <- map["html_attributions"]
        result <- map["result"]
        status <- map["status"]
    }
}

class ResultDetailPlace: Mappable {
    var address_components: [Address_components]?
    var adr_address: String?
    var business_status: String?
    var current_opening_hours: Current_opening_hours?
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
    var rating: Double?
    var reference: String?
    var reviews: [Reviews]?
    var types: [String]?
    var url: String?
    var user_ratings_total: Int?
    var utc_offset: Int?
    var vicinity: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        address_components <- map["address_components"]
        adr_address <- map["adr_address"]
        business_status <- map["business_status"]
        current_opening_hours <- map["current_opening_hours"]
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
        rating <- map["rating"]
        reference <- map["reference"]
        reviews <- map["reviews"]
        types <- map["types"]
        url <- map["url"]
        user_ratings_total <- map["user_ratings_total"]
        utc_offset <- map["utc_offset"]
        vicinity <- map["vicinity"]
    }
}

class Address_components: Mappable {
    var long_name: String?
    var short_name: String?
    var types: [String]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        long_name <- map["long_name"]
        short_name <- map["short_name"]
        types <- map["types"]
    }
}

class Current_opening_hours: Mappable {
    var open_now: Bool?
    var periods: [Periods]?
    var weekday_text: [String]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        open_now <- map["open_now"]
        periods <- map["periods"]
        weekday_text <- map["weekday_text"]
    }
}

class Periods: Mappable {
    var close: Close?
    var open: Open?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        close <- map["close"]
        open <- map["open"]
    }
}

class Close: Mappable {
    var date: String?
    var day: Int?
    var time: String?
    var truncated: Bool?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        date <- map["date"]
        day <- map["day"]
        time <- map["time"]
        truncated <- map["truncated"]
    }
}

class Open: Mappable {
    var date: String?
    var day: Int?
    var time: String?
    var truncated: Bool?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        date <- map["date"]
        day <- map["day"]
        time <- map["time"]
        truncated <- map["truncated"]
    }
}

class Reviews: Mappable {
    var author_name: String?
    var author_url: String?
    var profile_photo_url: String?
    var rating: Int?
    var relative_time_description: String?
    var text: String?
    var time: Double?
    var translated: Bool?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        author_name <- map["author_name"]
        author_url <- map["author_url"]
        profile_photo_url <- map["profile_photo_url"]
        rating <- map["rating"]
        relative_time_description <- map["relative_time_description"]
        text <- map["text"]
        time <- map["time"]
        translated <- map["translated"]
    }
}
