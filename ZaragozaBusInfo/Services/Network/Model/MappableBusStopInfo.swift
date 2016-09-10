//
//  MappableBusInfo.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 03/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import Foundation
import ObjectMapper

final class MappableBusStopInfo: Mappable {
    
    /* row json data to parse
     
     "id" : "731",
     "title" : "PLZ CANTERAS",
     "lat" : 41.63139435772203,
     "lon" : -0.8861435850916189,
     "lines" : [
     "C1"
     ],
     "subtitle" : "(731) C1"
     
     */
    
    var id: String?
    var title: String?
    var lat: Double?
    var lon: Double?
    var lines: [String]?
    var subtitle: String?
    
    /*
     I assumed all of these fields as optional 'cause
     I don't have any kind of Model Specification's Document
     */
    
    init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        lat <- map["lat"]
        lines <- map["lines"]
        subtitle <- map["subtitle"]
    }
}

final class BusInfoStopLocationsResponse: Mappable {
    var locations: [MappableBusStopInfo]?
    
    init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        locations <- map["locations"]
    }
}