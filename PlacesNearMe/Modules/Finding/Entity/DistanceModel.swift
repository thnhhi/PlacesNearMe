//
//  DistanceModel.swift
//  PlacesNearMe
//
//  Created by VTVH on 24/7/25.
//

import ObjectMapper

class DistanceModel: Mappable {
    var destination_addresses: [String]?
    var origin_addresses: [String]?
    var rows: [Rows]?
    var status: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        destination_addresses <- map["destination_addresses"]
        origin_addresses <- map["origin_addresses"]
        rows <- map["rows"]
        status <- map["status"]
    }
}

class Rows: Mappable {
    var elements: [Elements]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        elements <- map["elements"]
    }
}

class Elements: Mappable {
    var distance: Distance?
    var duration: Duration?
    var status: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        distance <- map["distance"]
        duration <- map["duration"]
        status <- map["status"]
    }
}

class Distance: Mappable {
    var text: String?
    var value: Int?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        text <- map["text"]
        value <- map["value"]
    }
}

class Duration: Mappable {
    var text: String?
    var value: Int?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        text <- map["text"]
        value <- map["value"]
    }
}
